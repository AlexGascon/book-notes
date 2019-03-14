defmodule Ring do
  def create_processes(n) do
    1..n |> Enum.map(fn _ -> spawn(fn -> loop end) end)
  end

  def loop do
    receive do
      {:link, link_to} when is_pid(link_to) ->
        Process.link link_to
        loop
      :crash ->
        1/0
    end
  end

  def link_processes(processes) do
    # Entry point
    link_processes(processes, [])
  end

  def link_processes([process_1, process_2 | rest], linked_processes) do
    # Link the first two processes of the list
    send(process_1, {:link, process_2})

    # Remove one of the processes we just linked of the 'process' list
    # Move it to a list of linked processes
    link_processes([process_2 | rest], [process_1 | linked_processes])
  end

  def link_processes([process | []], linked_processes) do
    # Link the last process in the list to the first one
    first_process = List.last(linked_processes)
    send(process, {:link, first_process})

    :ok
  end
end
