defmodule TrainsElixir.TraintimeController do
  use TrainsElixir.Web, :controller

  alias TrainsElixir.Traintime

  def index(conn, _params) do
    traintime = Repo.all(from i in Traintime, 
        where: i."ScheduledTime" > ^DateTime.utc_now(),
        order_by: [asc: i."ScheduledTime"], 
        limit: 15)
    render(conn, "index.html", traintime: traintime)
  end

  def new(conn, _params) do
    changeset = Traintime.changeset(%Traintime{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"traintime" => traintime_params}) do
    changeset = Traintime.changeset(%Traintime{}, traintime_params)

    case Repo.insert(changeset) do
      {:ok, _traintime} ->
        conn
        |> put_flash(:info, "Traintime created successfully.")
        |> redirect(to: traintime_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    traintime = Repo.get!(Traintime, id)
    render(conn, "show.html", traintime: traintime)
  end

  def edit(conn, %{"id" => id}) do
    traintime = Repo.get!(Traintime, id)
    changeset = Traintime.changeset(traintime)
    render(conn, "edit.html", traintime: traintime, changeset: changeset)
  end

  def update(conn, %{"id" => id, "traintime" => traintime_params}) do
    traintime = Repo.get!(Traintime, id)
    changeset = Traintime.changeset(traintime, traintime_params)

    case Repo.update(changeset) do
      {:ok, traintime} ->
        conn
        |> put_flash(:info, "Traintime updated successfully.")
        |> redirect(to: traintime_path(conn, :show, traintime))
      {:error, changeset} ->
        render(conn, "edit.html", traintime: traintime, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    traintime = Repo.get!(Traintime, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(traintime)

    conn
    |> put_flash(:info, "Traintime deleted successfully.")
    |> redirect(to: traintime_path(conn, :index))
  end
end
