defmodule TrainsElixir.Router do
  use TrainsElixir.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TrainsElixir do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/traintime", TraintimeController
    get "/traintime", TraintimeController, :index
    get "/traintime/:id", TraintimeController, :show
    
    
    
  end

  # Other scopes may use custom stacks.
  # scope "/api", TrainsElixir do
  #   pipe_through :api
  # end
end
