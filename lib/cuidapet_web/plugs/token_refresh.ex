defmodule CuidapetWeb.Plugs.TokenRefresh do
  import Plug.Conn

  alias CuidapetWeb.Auth.Guardian

  def init(options), do: options

  def call(%Plug.Conn{} = conn, _options) do
    ["Bearer " <> token] = get_req_header(conn, "authorization")

    case Guardian.refresh(token, token_type: "refresh", ttl: {1, :day}) do
      {:ok, _old_stuff, {new_token, _new_claims}} ->
        put_req_header(conn, "authorization", new_token)

      _error ->
        render_error(conn)
    end
  end

  def call(conn, _opts), do: conn

  defp render_error(conn) do
    body = Jason.encode!(%{message: "Invalid Token"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(:bad_request, body)
    |> halt()
  end
end
