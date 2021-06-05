use Mix.Config

config :bureau,
  sisyphe_url: "http://localhost:8000"

config :bureau, Bureau.Repo,
  database: Path.expand("../priv/data.db", __DIR__)

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with webpack to recompile .js and .css sources.
config :bureau, BureauWeb.Endpoint,
  http: [port: 9000],
  # https: [
  #   port: 9000,
  #   cipher_suite: :strong,
  #   keyfile: "priv/cert/selfsigned_key.pem",
  #   certfile: "priv/cert/selfsigned.pem"
  # ],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: [
      "node_modules/webpack/bin/webpack.js",
      "--mode",
      "development",
      "--watch-stdin",
      cd: Path.expand("../assets", __DIR__)
    ]
  ]

# Watch static and templates for browser reloading.
config :bureau, BureauWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/bureau_web/(live|views)/.*(ex)$",
      ~r"lib/bureau_web/templates/.*(eex)$"
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime
