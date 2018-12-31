defmodule AlewordfireWeb.PageController do
  use AlewordfireWeb, :controller

  def index(conn, params) do
    page = Map.get(params, "page", 1)
    canonical_path = Routes.blog_page_path(conn, :index, page)

    conn
    |> assign(:canonical_path, canonical_path)
    |> render("index.html")
  end
end
