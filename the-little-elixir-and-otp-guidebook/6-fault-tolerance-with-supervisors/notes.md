# 6 - Fault tolerance with supervisors

## 6.2 - Implementing the worker supervisor
In the section 6.2.3 there's a nice explanation of the different supervision strategies, take a look at it when I need to refresh the knowledge

### Putting everything into practice
After all the implementations in the section, the book talks about trying a few commands in IEx to see how everything works

Start a WorkerSupervisor that will supervise SampleWorker processes, and start a child linked to it

```elixir
{:ok, supervisor_pid} = Pooly.WorkerSupervisor.start_link({SampleWorker, :start_link, []})

{:ok, child_pid} = Supervisor.start_child(supervisor_pid, [[]])
```

We can repeat the last command as many times as we want to create several processes. Then, there are a few interesting commands that can help us have an overview of the child processes.

# 6.3 - Implementing the Server: the brains of the operation
Here we'll extract the business logic to a separate process that will also communicate with the supervisor. We want the supervisor to have as little logic as possible, because more logic means more probability of failure.

We have defined a lot of init clauses, one for one each option we care about. However, the good part is that we have very little logic on each of them.

The last init function sends a message to start the supervisor. Messages to self are captured by `handle_info`.


When creating the supervisor, we'll specify that the default restart behavior is `:temporary`, i.e. the server won't automatically restart the Worker's supervisor. This is because we want to implement a custom restarting behavior, and therefore we need the server to just ignore crashes on it so we can completely handle them.


### Understanding ETSs
ETS or Erlang Term Storage is basically a very efficient in-memory database built to store Erlang or Elixir data. It comes by default in Erlang, which means that we don't need to install any dependency.

Let's learn more about them in the following examples:

##### Creating an ETS table
We'll create a table to store TV shows, their IMDb rating and their main character.

```elixir
iex> :ets.new(:tv_shows, [:set, :private, :named_table])
#Reference<0.3238206512.2083389443.116580>
```

The second parameter are the options. Some things we can specify are:
  - **Table types:** `:set`, `:ordered_set`, `:bag` (rows with the same keys are alllowed, but the content must be different), and `:duplicate_bag` (same as bag but without row-uniqueness).
  - **Access rights:** Owner always has read+write permissions. This rights affect the rest of the processes. `:protected` (default, other processes can only read), `:public` (every process can read and right) and `:private` (only owner can read and write)
  - **Named table:** Allows us to reference the ETS with its symbol name, without needing to use the reference

Let's now do some operations with it:

```elixir
iex(5)> :ets.insert(:tv_shows, {"The Flash", "Grant Gustin", 7.9})  
true

iex(6)> :ets.insert(:tv_shows, {"How I Met Your Mother", "Josh Radnor", 8.3})
true

iex(7)> :ets.insert(:tv_shows, {"Supergirl", "Melissa Benoist", 6.4})        
true

iex(8)> :ets.insert(:tv_shows, {"Agents of S.H.I.E.L.D.", "Chloe Bennet", 7.5})
true

iex(9)> :ets.tab2list :tv_shows
[
  {"The Flash", "Grant Gustin", 7.9},
  {"Agents of S.H.I.E.L.D.", "Chloe Bennet", 7.5},
  {"Supergirl", "Melissa Benoist", 6.4},
  {"How I Met Your Mother", "Josh Radnor", 8.3}
]

# Actually, it's been a while since I last watched Agents of S.H.I.E.L.D.
iex(10)> :ets.delete(:tv_shows, "Agents of S.H.I.E.L.D.")
true

iex(11)> :ets.tab2list :tv_shows                         
[
  {"The Flash", "Grant Gustin", 7.9},
  {"Supergirl", "Melissa Benoist", 6.4},
  {"How I Met Your Mother", "Josh Radnor", 8.3}
]

# To search data, we can either use :ets.lookup to look by key
iex(12)> :ets.lookup(:tv_shows, "The Flash")
[{"The Flash", "Grant Gustin", 7.9}]

# Or :ets.match to look by any other value
iex(13)> :ets.match(:tv_shows, {:"$1", "Grant Gustin", :"$2"}) 
[["The Flash", 7.9]]

iex(15)> :ets.match(:tv_shows, {:"$2", "Grant Gustin", :"$1"})
[[7.9, "The Flash"]]

iex(31)> :ets.match(:tv_shows, {:"$1", "Grant Gustin", :_})  
[["The Flash"]]

# Using "$N" is to specify that we want to display that field in the N position
# Using an underscore is to specify that we don't want that field in the result

# It's important to note that the result returns a list: this happens because some
# ets types (e.g. bag) can have multiple entries for a key
```

The goal of all this explanation was because we're going to use ETS to store monitors data. Now that we've understood them, let's continue with the project.

### Back to workers
Here there are two important terms that we'll use a lot and that we need to fully understand:

- **Check-out a worker:** Obtain a worker from the pool
- **Check-in a worker:** Return a worker back to the pool of available ones

We'll start implementing the checkout operation. Here, it's **very important to retain the PID of the process checking out the worker**, because we need to know that information in case it dies and we need to take any action. It does not happen yet, but it will soon.

_(Note that we have also updated the first `init` method to include the `monitors` information)_

## 6.4. Implementing the top level supervisor