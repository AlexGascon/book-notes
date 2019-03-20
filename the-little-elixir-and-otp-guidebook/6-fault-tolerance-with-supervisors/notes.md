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


