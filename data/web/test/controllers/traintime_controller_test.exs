defmodule TrainsElixir.TraintimeControllerTest do
  use TrainsElixir.ConnCase

  alias TrainsElixir.Traintime
  @valid_attrs %{Destination: "some content", Lateness: 42, Origin: "some content", ScheduledTime: 42, Status: "some content", TimeStamp: 42, Track: "some content", Trip: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, traintime_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing traintime"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, traintime_path(conn, :new)
    assert html_response(conn, 200) =~ "New traintime"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, traintime_path(conn, :create), traintime: @valid_attrs
    assert redirected_to(conn) == traintime_path(conn, :index)
    assert Repo.get_by(Traintime, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, traintime_path(conn, :create), traintime: @invalid_attrs
    assert html_response(conn, 200) =~ "New traintime"
  end

  test "shows chosen resource", %{conn: conn} do
    traintime = Repo.insert! %Traintime{}
    conn = get conn, traintime_path(conn, :show, traintime)
    assert html_response(conn, 200) =~ "Show traintime"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, traintime_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    traintime = Repo.insert! %Traintime{}
    conn = get conn, traintime_path(conn, :edit, traintime)
    assert html_response(conn, 200) =~ "Edit traintime"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    traintime = Repo.insert! %Traintime{}
    conn = put conn, traintime_path(conn, :update, traintime), traintime: @valid_attrs
    assert redirected_to(conn) == traintime_path(conn, :show, traintime)
    assert Repo.get_by(Traintime, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    traintime = Repo.insert! %Traintime{}
    conn = put conn, traintime_path(conn, :update, traintime), traintime: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit traintime"
  end

  test "deletes chosen resource", %{conn: conn} do
    traintime = Repo.insert! %Traintime{}
    conn = delete conn, traintime_path(conn, :delete, traintime)
    assert redirected_to(conn) == traintime_path(conn, :index)
    refute Repo.get(Traintime, traintime.id)
  end
end
