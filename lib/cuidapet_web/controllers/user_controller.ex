defmodule CuidapetWeb.UserController do
  use CuidapetWeb, :controller

  alias Cuidapet.Users.User
  alias CuidapetWeb.{Auth.Guardian, FallbackController}

  action_fallback FallbackController

  def sign_in(conn, %{"id" => _id, "password" => _password} = params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("sign_in.json", token: token)
    end
  end

  def create(conn, params) do
    with {:ok, %User{} = user} <- Cuidapet.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("create.json", token: token, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{}} <- Cuidapet.delete_user(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Cuidapet.get_user_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def update(conn, %{} = params) do
    with {:ok, %User{} = user} <- Cuidapet.update_user(params) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end
end
