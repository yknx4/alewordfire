defmodule AlewordfireWeb.AboutController do
  use AlewordfireWeb, :controller

  def index(conn, _params) do
    conn
    |> render("index.html")
  end
end
