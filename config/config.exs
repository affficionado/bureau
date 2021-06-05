# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bureau,
  ecto_repos: [Bureau.Repo]

# Configures the endpoint
config :bureau, BureauWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "e6eGHmrz4xqijzc0jrbM04UaCtnrgOJgfMyfqzX5IB3QAoqMQBkBG3o38xupnDen",
  render_errors: [view: BureauWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Bureau.PubSub,
  live_view: [signing_salt: "fVAj4HzJ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Floki
config :floki, :html_parser, Floki.HTMLParser.FastHtml

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
