# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :cuidapet,
  ecto_repos: [Cuidapet.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :cuidapet, CuidapetWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vkbViKr6RnGI2LR8azJDYd03SuV4/u/fnWWh98rHrl25q49rZVcVif4M1mrQ4rAW",
  render_errors: [view: CuidapetWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Cuidapet.PubSub,
  live_view: [signing_salt: "+4ojZ0g9"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
