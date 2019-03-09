defmodule PingPong.Pong do
  def loop do
    receive do
      {sender_pid, :pong} ->
        send(sender_pid, :ping)
      message ->
        IO.inspect(message, label: "I don't know what to do with that message")
    end
    loop
  end
end
