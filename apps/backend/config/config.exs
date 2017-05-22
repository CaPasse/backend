use Mix.Config

config :backend, ecto_repos: [Backend.Repo]

import_config "#{Mix.env}.exs"
