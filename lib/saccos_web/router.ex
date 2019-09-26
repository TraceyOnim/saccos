defmodule SaccosWeb.Router do
  use SaccosWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug SaccosWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SaccosWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/farmers", FarmerController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", SaccosWeb do
  #   pipe_through :api
  # end
end
