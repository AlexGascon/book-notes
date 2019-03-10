defmodule Metex.Worker do
  use GenServer

  ## Client API

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def get_temperature(pid, location) do
    GenServer.call(pid, {:location, location})
  end

  ## Server Callbacks

  def init(:ok) do
    # Callback to start_link
    # Format: {:ok, initial_state}
    {:ok, %{}}
  end

  def handle_call({:location, location}, _from, stats) do
    case temperature_of(location) do
      {:ok, temperature} ->
        # Format: {:reply, reply, state}
        {:reply, {:ok, "#{location}: #{temperature} C"}, update_stats(stats, location)}
      _ ->
        # Format: {:reply, reply, state}
        {:reply, {:error, "Temperature not found for #{location}"}, stats}
    end
  end

  ## Helper Functions

  def temperature_of(location) do
    location |> url_for |> HTTPoison.get |> parse_response
  end

  defp url_for(location) do
    location = URI.encode(location)

    "http://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=#{apikey}"
  end

  defp parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    body |> JSON.decode! |> compute_temperature
  end

  defp parse_response(_) do
    :error
  end

  defp compute_temperature(json) do
    try do
      temp = (json["main"]["temp"] - 273.15) |> Float.round(1)
      {:ok, temp}
    rescue
      _ -> :error
    end
  end

  defp update_stats(stats, location) do
    stats |> Map.update(location, 1, &(&1 + 1))
  end

  defp apikey do
    "27f3eb34255b544dc5ec5972823d5d36"
  end
end
