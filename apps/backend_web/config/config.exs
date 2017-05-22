# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :backend_web,
  namespace: CP.Web,
  ecto_repos: [CP.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :backend_web, CP.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Pew/FtLSFO1PzcI7cxmhonHgsu3rQv1mW6KPlDMa4/2EORlXd3efSlfo9j1Ipkzs",
  render_errors: [view: CP.Web.ErrorView, accepts: ~w(json)],
  pubsub: [name: CP.Web.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :backend_web, :generators,
  context_app: :backend

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
