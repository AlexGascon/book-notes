defmodule RingTest do
  use ExUnit.Case
  doctest Ring

  test "greets the world" do
    assert Ring.hello() == :world
  end
end
