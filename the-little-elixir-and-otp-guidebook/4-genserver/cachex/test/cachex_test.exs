defmodule CachexTest do
  use ExUnit.Case
  doctest Cachex

  def setup do
    {:ok, _pid} = Cachex.start_link
  end

  test "write stores a key-value pair" do
  end

  test "write overrides the value if the key is already present" do
  end

  test "read retrieves the value of a stored key"

  test "read retrieves nil if the key is not stored"

  test "delete removes a key"

  test "clear resets the entire memory"

  test "exist? returns true if the key is stored"

  test "exist? returns false if the key is not stored"
end
