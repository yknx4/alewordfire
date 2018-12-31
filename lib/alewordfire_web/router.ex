defmodule AlewordfireWeb.Router do
  use AlewordfireWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Metatags
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AlewordfireWeb do
    pipe_through :browser

    get "/about", AboutController, :index
    get "/blog/:page", PageController, :index, as: :blog_page
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", AlewordfireWeb do
  #   pipe_through :api
  # end
end
