# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :trains_elixir,
  ecto_repos: [TrainsElixir.Repo]

# Configures the endpoint
config :trains_elixir, TrainsElixir.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "OoAbiL9jcY3ri54tCN9S+A61fYVyOoixf1SwOLSZ4ozUbykpHkAmX5l4HBbVB0cF",
  render_errors: [view: TrainsElixir.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TrainsElixir.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
