use Mix.Config

# Configure your database
config :backend, Backend.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "backend_dev",
  hostname: "localhost",
  pool_size: 10
