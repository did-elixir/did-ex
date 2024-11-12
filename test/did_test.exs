defmodule DIDTest do
  use ExUnit.Case
  doctest DID

  test "greets the world" do
    assert DID.hello() == :world
  end
end
