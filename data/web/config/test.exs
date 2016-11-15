use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :trains_elixir, TrainsElixir.Endpoint,
  http: [port: 9999],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :trains_elixir, TrainsElixir.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "trains",
  password: "trains",
  database: "trains_elixir",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
