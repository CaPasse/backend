# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :hound, browser: "chrome"
config :hound, http: [recv_timeout: :infinity]

import_config "#{Mix.env}.exs"
