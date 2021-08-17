# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :maple,
  ecto_repos: [Maple.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :maple, MapleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "8fpLTniWp4uh1XkQlB7lM0+QPQ1oEsDKyyi+MtD9w+U53gCdkBwGzoShw8XJ1Bj7",
  render_errors: [view: MapleWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Maple.PubSub,
  live_view: [signing_salt: "rvOgCaHg"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
