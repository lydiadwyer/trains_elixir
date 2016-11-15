defmodule TrainsElixir.Traintime do
  use TrainsElixir.Web, :model


  schema "traintime" do

    field :TimeStamp,        Ecto.DateTime
    field :Origin,           :string
    field :Trip,             :string
    field :Destination,      :string
    field :ScheduledTime,    Ecto.DateTime
    field :Lateness,         :integer
    field :Track,            :string
    field :Status,           :string


  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:TimeStamp, :Origin, :Trip, :Destination, :ScheduledTime, :Lateness, :Track, :Status])
    |> validate_required([:TimeStamp, :Origin, :Trip, :Destination, :ScheduledTime, :Lateness, :Status])
  end
end
