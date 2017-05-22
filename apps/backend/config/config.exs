use Mix.Config

config :backend, ecto_repos: [CP.Repo]

import_config "#{Mix.env}.exs"
