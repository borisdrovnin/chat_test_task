# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :chat_test_task,
  ecto_repos: [ChatTestTask.Repo]

# Configures the endpoint
config :chat_test_task, ChatTestTaskWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uGHUg9GP5R91vwBI8n6HI3SGKOjDtpd3EBRNgKbkshZT+y+n3IkACb2ZqxOo5BDI",
  render_errors: [view: ChatTestTaskWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ChatTestTask.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
