defmodule FetchrTest do
  use ExUnit.Case
  doctest Fetchr

  test "greets the world" do
    assert Fetchr.hello() == :world
  end
end
