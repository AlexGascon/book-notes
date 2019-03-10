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

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts ++ [name: @name])
  end

  @doc """
  Store `value` associating it to `key`
  """
  def write(key, value) do
    GenServer.cast(:write, {key, value})
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

  ## Server Callbacks

  ## Helper functions
end
