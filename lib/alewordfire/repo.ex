defmodule Alewordfire.Repo do
  use Ecto.Repo,
    otp_app: :alewordfire,
    adapter: Ecto.Adapters.Postgres
end
