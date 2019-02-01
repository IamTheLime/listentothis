defmodule ListentothisWeb.Router do
  use ListentothisWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Listentothis.Auth, repo: Listentothis.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ListentothisWeb do
    pipe_through :browser # Use the default browser stack
    get "/", PageController, :index
    get "/users/signup", UserController, :new
    post "/users", UserController, :create
    get "/users", UserController, :index
    get "/users/:id", UserController, :show
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/music", MusicController, only: [:index, :show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", ListentothisWeb do
  #   pipe_through :api
  # end
end
