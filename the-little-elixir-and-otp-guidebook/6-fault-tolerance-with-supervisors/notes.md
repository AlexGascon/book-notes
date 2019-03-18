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

We can repeat the last command as many times as we want to create several processes. Then, there are a few interesting commands that can help us have an overview of the child processes:


