defmodule PingPong.Ping do
  def loop do
    receive do
      {sender_pid, :ping} ->
        send(sender_pid, :pong)
      message ->
        IO.inspect(message, label: "I don't know what to do with that message")
    end
    loop
  end
end
