defmodule TryoutGenTest do
  use ExUnit.Case
  doctest TryoutGen

  test "greets the world" do
    assert TryoutGen.hello() == :world
  end
end
