defmodule TrainsElixir.TraintimeTest do
  use TrainsElixir.ModelCase

  alias TrainsElixir.Traintime

  @valid_attrs %{Destination: "some content", Lateness: 42, Origin: "some content", ScheduledTime: 42, Status: "some content", TimeStamp: 42, Track: 42, Trip: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Traintime.changeset(%Traintime{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Traintime.changeset(%Traintime{}, @invalid_attrs)
    refute changeset.valid?
  end
end
