defmodule ClusterDemoTest do
  use ExUnit.Case
  doctest ClusterDemo

  test "greets the world" do
    assert ClusterDemo.hello() == :world
  end
end
