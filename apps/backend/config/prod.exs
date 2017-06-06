use Mix.Config

import_config "prod.secret.exs"

config :tirexs, :uri, "http://elasticsearch:9200"
