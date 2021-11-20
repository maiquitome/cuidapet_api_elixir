defmodule CuidapetWeb.Router do
  use CuidapetWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug CuidapetWeb.Auth.Pipeline
  end

  scope "/api", CuidapetWeb do
    pipe_through :api

    # resources "/user", UsersController, except: [:edit, :new]
  end

  scope "/", CuidapetWeb do
    pipe_through [:api, :auth]

    # get "/user/users", UserController, :index
    get "/user/:id", UserController, :show
    put "/user/:id", UserController, :update
    delete "/user/:id", UserController, :delete
  end

  scope "/", CuidapetWeb do
    pipe_through :api

    post "/user", UserController, :create
    post "/user/signin", UserController, :sign_in
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: CuidapetWeb.Telemetry
    end
  end
end
