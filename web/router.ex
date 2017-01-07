defmodule Login.Router do
  use Login.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Login do
    pipe_through [:browser, :browser_session]

    get "/", PageController, :index
    get "/registro", LoginController, :registro
    post "/registro", LoginController, :post_registro
    get "/login", LoginController, :login
    post "/login", LoginController, :post_login
    get "/logout", LoginController , :logout
  end

  # Other scopes may use custom stacks.
  # scope "/api", Login do
  #   pipe_through :api
  # end
end
