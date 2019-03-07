## 3.4 Creating processes for concurrency

After adding the changes in sections 3.4.1 and 3.4.2, we can send messages to the worker. We can do that with the following code:

```elixir
# Initializing the Metex worker and specifying it to run using the :loop method without arguments
pid = spawn(Metex.Worker, :loop, [])

# Sending to Metex the location we want to analyze and our PID so it can answer us
send(pid, {self, "Valencia"})

# Receiving the response
flush
{:ok, "Valencia: 13.4 C"}
:ok

# Now we'll repeat the process for several cities concurrently
cities = ["Madrid", "Tavernes de la Valldigna", "Manchester", "New York"]
cities |> Enum.each(fn city ->
		pid = spawn(Metex.Worker, :loop, [])
		send(pid, {self, city})
	       end)
#:ok
flush
# {:ok, "Madrid: 6.4 C"}
# {:ok, "New York: -5.4 C}
# {:ok, "Manchester: -8.4 C}"
# {:ok, "Tavernes de la Valldigna: 13.9 C}"
:ok
```

As the results were processed concurrently, they were received back but without following any particular order.
