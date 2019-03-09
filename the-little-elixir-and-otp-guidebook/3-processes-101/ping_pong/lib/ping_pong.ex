defmodule PingPong do
  def start_pingpong do
    ping_pid = spawn(PingPong.Ping, :loop, [])
    pong_pid = spawn(PingPong.Pong, :loop, [])

    ping_pid |> IO.inspect(label: "PING")
    pong_pid |> IO.inspect(label: "PONG")

    {ping_pid, pong_pid}
  end
end
