defmodule CuidapetWeb.Auth.ErrorHandler do
  alias Guardian.Plug.ErrorHandler
  alias Plug.Conn

  @behaviour ErrorHandler

  # auth_error(conn, {:unauthenticate, :unauthenticate}, _opts)
  def auth_error(conn, {error, _reason}, _opts) do
    body = Jason.encode!(%{"message" => to_string(error)})

    # 401 unauthorized
    Conn.send_resp(conn, 401, body)
  end
end
