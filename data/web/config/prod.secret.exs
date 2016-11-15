use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :trains_elixir, TrainsElixir.Endpoint,
  secret_key_base: "R25Cb4N9wNDDeV5PROCN4+diym0dDjAWUHuaKhTwAtwPaihTZe1gR9OO3QvVN3+6"

# Configure your database
config :trains_elixir, TrainsElixir.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "trains_elixir_prod",
  pool_size: 20
