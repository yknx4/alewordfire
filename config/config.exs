# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :alewordfire,
  ecto_repos: [Alewordfire.Repo]

# Configures the endpoint
config :alewordfire, AlewordfireWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CMmaUom7KW8KTIqYR18zKXhhUhYTINOVu0oRlFZbo8gF/j7ZDJDtVzGtWZwlcWX7",
  render_errors: [view: AlewordfireWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Alewordfire.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :metatags,
    sitename: "Ale World",
    separator: "-"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

