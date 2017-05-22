use Mix.Config

# Configure your database
config :backend, Backend.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "backend_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
