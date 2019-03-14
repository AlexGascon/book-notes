defmodule ThySupervisor do
  use GenServer

  # Client API

  def start_link(child_spec_list) do
    # spec format: {Module, method, arguments}
    # example: {ThyWorker, :start_link, []}
    GenServer.start_link(__MODULE__, [child_spec_list])
  end

  def start_child(supervisor, child_spec) do
    GenServer.call(supervisor, {:start_child, child_spec})
  end

  def terminate_child(supervisor, pid) do
    GenServer.call(supervisor, {:terminate_child, pid})
  end

  def restart_child(supervisor, pid, child_spec) do
    GenServer.call(supervisor, {:restart_child, pid, child_spec})
  end

  def count_children(supervisor) do
    GenServer.call(supervisor, :count_children)
  end

  def which_children(supervisor) do
    GenServer.call(supervisor, :which_children)
  end

  # Server Callbacks

  def init([child_spec_list]) do
    Process.flag(:trap_exit, true)
    state = child_spec_list
            |> start_children
            |> Enum.into(Map.new)

    {:ok, state}
  end

  def handle_call({:start_child, child_spec}, _from, state) do
    case start_child(child_spec) do
      {:ok, pid} ->
        new_state = state |> Map.put(pid, child_spec)
        {:reply, {:ok, pid}, new_state}
      :error ->
        {:reply, {:error, "Error starting child"}, state}
    end
  end

  def handle_call({:terminate_child, child_pid}, _from, state) do
    case terminate_child(child_pid) do
      :ok ->
        new_state = state |> Map.delete(child_pid)
        {:reply, :ok, new_state}
      :error ->
        {:reply, {:error, "Error terminating child"}, state}
    end
  end

  def handle_call({:restart_child, old_pid, child_spec}, _from, state) do
    case Map.get(state, old_pid) do
      old_child_spec ->
        case restart_child(old_pid, child_spec) do
          {:ok, {new_pid, child_spec}} ->
            new_state = state
                        |> Map.delete(old_pid)
                        |> Map.put(new_pid, child_spec)
            {:reply, {:ok, new_pid}, new_state}
          :error ->
            {:reply, "Error restarting child", state}
        end
      nil ->
        {:reply, :ok, state}
    end
  end

  def handle_call(:count_children, _from, state) do
    {:reply, Enum.count(state), state}
  end

  def handle_call(:which_children, _from, state) do
    {:reply, state, state}
  end

  # Confirming that the child got terminated
  def handle_info({:EXIT, from, :killed}, state) do
    new_state = state |> Map.delete(from)
    {:noreply, new_state}
  end

  # Processes that exit normally: supervisor doesn't need to do anything
  def handle_info({:EXIT, from, :normal}, state) do
    new_state = state |> Map.delete(from)
    {:noreply, new_state}
  end

  def handle_info({:EXIT, from, reason}, state) do
    case Map.fetch(state, from) do
      {:ok, old_child_spec} ->
        case restart_child(from, old_child_spec) do
          {:ok, {new_pid, new_child_spec}} ->
            new_state = state
                        |> Map.delete(from)
                        |> Map.put(new_pid, new_child_spec)
            {:noreply, new_state}
          :error ->
            {:noreply, state}
        end
      _ ->
        {:noreply, state}
    end
  end

  def terminate(_reason, state) do
    terminate_children(state)
    :ok
  end

  # Helpers

  defp start_child({module, function, args}) do
    # Start the server located in the module `mod`, by running the function
    # `fun` with the arguments `args`. If a server starts, return its PID
    case apply(module, function, args) do
      pid when is_pid(pid) ->
        Process.link(pid)
        {:ok, pid}
      _ ->
        :error
    end
  end

  defp start_children([]), do: []
  defp start_children([child_spec | rest]) do
    case start_child(child_spec) do
      {:ok, pid} ->
        [{pid, child_spec}, start_children(rest)]
      :error ->
        :error
    end
  end

  defp restart_child(pid, child_spec) when is_pid(pid) do
    case terminate_child(pid) do
      :ok ->
        case start_child(child_spec) do
          {:ok, new_pid} ->
            {:ok, {new_pid, child_spec}}
          :error ->
            :error
        end
      :error ->
        :error
    end
  end

  defp terminate_child(pid) do
    # This will send a {:EXIT, child_pid, :killed} message to the supervisor
    Process.exit(pid, :kill)
    :ok
  end

  defp terminate_children([]), do: :ok
  defp terminate_children(child_specs) do
    child_specs |> Enum.each(fn {pid, _} -> terminate_child(pid) end)
  end
end
