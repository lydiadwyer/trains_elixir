# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TrainsElixir.Repo.insert!(%TrainsElixir.traintime{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
# http://wsmoak.net/2016/02/16/phoenix-ecto-seeds-csv.html seed the data from csv


alias TrainsElixir.Traintime
alias TrainsElixir.Repo

defmodule TrainsElixir.Seeds do
    
    def store_it(row) do

        
        ## CURRENTLY IN UTC
        ##
        
        # CSV takes time timestamp in as a string, need to convert this to an INT
        # Update row maps of TimeStamp and ScheduledTime to INTs
        
        # https://til.hashrocket.com/posts/e3049162f7-updating-values-in-a-map
        {_, row} = Map.get_and_update(row, :TimeStamp,
            fn(val) ->
                {val, String.to_integer(val)} end )
        {_, row} = Map.get_and_update(row, :ScheduledTime,
            fn(val) ->
                {val, String.to_integer(val)} end )        
        
        
        # Now need to convert from epoch seconds to Erlang tuple to parse for DateTime
        # On TimeStamp, ScheduledTime
        # https://hexdocs.pm/ecto/Ecto.DateTime.html#cast/1
        # http://michal.muskala.eu/2015/07/30/unix-timestamps-in-elixir.html
        {_, row} = Map.get_and_update(row, :TimeStamp,
            fn(val) ->
                {val, DateTime.from_unix!(val)} end )

        {_, row} = Map.get_and_update(row, :ScheduledTime,
            fn(val) ->
                {val, DateTime.from_unix!(val)} end )


        # Create the changeset of CSV data to insert into Database
        changeset = Traintime.changeset(%Traintime{}, row)
        Repo.insert!(changeset)
    end
 
end

defmodule Download do
    def fetch_csv(url, out_filename) do
        IO.puts "Start downloading"
        body = HTTPoison.get!(url).body
        File.write!(out_filename, body)
        IO.puts "Done downloading"
    end
end





# function chain the conversion of the CSV
# download the departures.csv
Download.fetch_csv("http://developer.mbta.com/lib/gtrtfs/Departures.csv", "/var/www/trains_elixir/Departures.csv")

# now, read the CSV data into rows (drop the first CSV row of headers)
# Pass headers, enumerate each value and pass into the store_it function
IO.puts "Start inputting to database"
File.stream!("/var/www/trains_elixir/Departures.csv")
    |> Stream.drop(1) 
    |> CSV.decode(headers: [:TimeStamp, :Origin, :Trip, :Destination, :ScheduledTime, :Lateness, :Track, :Status])
    |> Enum.each(&TrainsElixir.Seeds.store_it/1)
# Delete departures.csv once read into the database
IO.puts "Deleting the CSV file."
File.rm!("/var/www/trains_elixir/Departures.csv")
