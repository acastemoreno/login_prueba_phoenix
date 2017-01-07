# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :login,
  ecto_repos: [Login.Repo]

# Configures the endpoint
config :login, Login.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "OVtqn0RDxa+rc07BqQKutIlG5C8GD0hiAlTFzVC17xMO56LVxcS19pqHavxu6UOt",
  render_errors: [view: Login.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Login.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
