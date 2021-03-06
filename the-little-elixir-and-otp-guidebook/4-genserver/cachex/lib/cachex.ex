defmodule Cachex do
  @moduledoc """
  Write a GenServer that can store any valid Elixir term, given a key. Here are a few operations to get you started:

    Cache.write(:stooges, ["Larry", "Curly", "Moe"])
    Cache.read(:stooges)
    Cache.delete(:stooges)
    Cache.clear
    Cache.exist?(:stooges)

  Structure your program similar to how you did in this chapter. In particular, pay attention to which of these operations should be handle_calls or handle_casts.
  """
  use GenServer

  @name CachexServer

  ## Client API

  def start_link(initial_state \\ %{}, opts \\ []) do
    GenServer.start_link(__MODULE__, initial_state, opts ++ [name: @name])
  end

  @doc """
  Store `value` associating it to `key`
  """
  def write(key, value) do
    GenServer.cast(@name, {:write, key, value})
  end

  @doc """
  Retrieve the value associated to `key`

  Return {:ok, value} if the key is present, :error otherwise
  """
  @spec read(any) :: {:ok, any} | :error
  def read(key) do
    GenServer.call(@name, {:read, key})
  end

  @doc """
  Delete the data for the given key
  """
  def delete(key) do
    GenServer.cast(@name, {:delete, key})
  end

  @doc """
  Reset all the server entries
  """
  def clear do
    GenServer.cast(@name, :clear)
  end

  @doc """
  Specify if `key` is present in the current memory set
  """
  @spec exist?(any) :: bool
  def exist?(key) do
    GenServer.call(@name, {:exist, key})
  end

  @doc """
  Stop the server
  """
  def stop do
    GenServer.cast(@name, :stop)
  end

  ## Server Callbacks
  def init(initial_state) do
    {:ok, initial_state}
  end

  def handle_call({:read, key}, _from, state) do
    {:reply, Map.get(state, key, :error), state}
  end

  def handle_call({:exist, key}, _from, state) do
    {:reply, Map.has_key?(state, key), state}
  end

  def handle_cast({:write, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  def handle_cast({:delete, key}, state) do
    {:noreply, Map.delete(state, key)}
  end

  def handle_cast(:clear, _state) do
    {:noreply, %{}}
  end

  def handle_cast(:stop, _state) do
    {:stop, :normal, state}
  end

  def handle_info(message, state) do
    IO.puts "Unknown message format: #{message}"

    {:noreply, state}
  end

  def terminate(reason, state) do
    IO.puts "Server stopped. Reason: #{reason}"
    IO.puts "Ending state: #{state}"

    :ok
  end
end
