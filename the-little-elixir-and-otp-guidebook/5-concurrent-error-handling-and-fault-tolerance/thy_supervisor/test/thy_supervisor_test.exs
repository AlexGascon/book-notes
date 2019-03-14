defmodule ThySupervisorTest do
  use ExUnit.Case
  doctest ThySupervisor

  test "greets the world" do
    assert ThySupervisor.hello() == :world
  end
end
