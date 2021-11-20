defmodule CuidapetWeb.Auth.Pipeline do
  # definir que é um pipeline
  use Guardian.Plug.Pipeline, otp_app: :cuidapet

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
