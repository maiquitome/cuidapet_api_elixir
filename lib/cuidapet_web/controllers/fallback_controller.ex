defmodule CuidapetWeb.FallbackController do
  use CuidapetWeb, :controller

  alias Cuidapet.Error
  alias CuidapetWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: changeset_or_message}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: changeset_or_message)
  end

  def call(conn, {:error, any}) do
    IO.inspect(any, label: "###############")

    conn
  end
end
