defmodule CachexTest do
  use ExUnit.Case, async: true
  doctest Cachex

  setup do
    {:ok, pid} = Cachex.start_link %{test_key: "test_value"}

    %{server: pid}
  end

  test "write stores a key-value pair", %{server: pid} do
    Cachex.write(:key, "value")

    assert Cachex.read(:key) == "value"
  end

  test "write overrides the value if the key is already present", %{server: pid}  do
    Cachex.write(:test_key, "test_overriden_value")

    assert Cachex.read(:test_key) == "test_overriden_value"
  end

  test "read retrieves the value of a stored key", %{server: pid}  do
    assert Cachex.read(:test_key) == "test_value"
  end

  test "read returns :error if the key is not stored", %{server: pid}  do
    assert Cachex.read(:non_present_key) == :error
  end

  test "delete removes an existing key", %{server: pid}  do
    Cachex.delete(:test_key)

    assert Cachex.read(:test_key) == :error
  end

  test "clear resets the entire memory", %{server: pid}  do
    Cachex.write(:key, "value")
    Cachex.write(:another_key, "another value")

    Cachex.clear

    assert Cachex.exist?(:test_key) == :false
    assert Cachex.exist?(:key) == :false
    assert Cachex.exist?(:another_key) == :false
  end

  test "exist? returns true if the key is stored", %{server: pid}  do
    assert Cachex.exist?(:test_key) == :true
  end

  test "exist? returns false if the key is not stored", %{server: pid}  do
    assert Cachex.exist?(:test_false_key) == :false
  end
end
