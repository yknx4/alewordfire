defmodule Alewordfire.Repo do
  use Ecto.Repo,
    otp_app: :alewordfire,
    adapter: Ecto.Adapters.Postgres

  def init(_type, config) do
    unless Keyword.has_key?(config, :url) do
      {:ok, Keyword.put(config, :url, System.get_env("DATABASE_URL"))}
    end
  end
end
