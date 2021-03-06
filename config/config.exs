# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :maple_tree,
  ecto_repos: [MapleTree.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :maple_tree, MapleTreeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "8fpLTniWp4uh1XkQlB7lM0+QPQ1oEsDKyyi+MtD9w+U53gCdkBwGzoShw8XJ1Bj7",
  render_errors: [view: MapleTreeWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: MapleTree.PubSub,
  live_view: [signing_salt: "rvOgCaHg"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :maple_tree, MapleTree.Scheduler,
  debug_logging: false,
  jobs: [
    {"@hourly", {MapleTree.Groups, :delete_expired_invite_codes, []}}
  ]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :maple_tree, MapleTreeWeb.Gettext, default_locale: "en", locales: ~w(en pt)


# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args:
      ~w(js/app.ts --bundle --target=es2016 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
