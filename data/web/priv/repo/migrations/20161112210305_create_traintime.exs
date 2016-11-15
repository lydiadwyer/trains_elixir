defmodule TrainsElixir.Repo.Migrations.CreateTraintime do
  use Ecto.Migration


  def change do
    create table(:traintime) do
      add :TimeStamp,        :utc_datetime
      add :Origin,           :string
      add :Trip,             :string
      add :Destination,      :string
      add :ScheduledTime,    :utc_datetime
      add :Lateness,         :integer
      add :Track,            :string
      add :Status,           :string


    end

  end
end
