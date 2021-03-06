use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :chat_test_task, ChatTestTaskWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :chat_test_task, ChatTestTask.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "chat_user_test",
  password: "123456",
  database: "chat_db_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
