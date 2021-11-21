defmodule Cuidapet.Users.Get do
  @moduledoc """
  Gets the users in the database.
  """
  alias Cuidapet.{Error, Repo, Users.User}

  @doc """
  Gets an user by id in the database.

  ## Examples

      iex> user_params = %{address: "Rua...", age: 28, cep: "12345678", cpf: "123456789100", email: "teste_teste@teste.com", name: "Maiqui Tomé", password: "123456"}

      iex> {:ok, user_schema} = Cuidapet.create_user(user_params)

      iex> {:ok, _user_schema} = Cuidapet.Users.Get.by_id(user_schema.id)

  """
  @spec by_id(binary) ::
          {:error, %{result: String.t, status: :not_found}}
          | {:ok, User.t}

  def by_id(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found()}
      user_schema -> {:ok, user_schema}
    end
  end

  @doc """
  Gets an user by email in the database.

  ## Examples

      iex> user_params = %{address: "Rua...", age: 28, cep: "12345678", cpf: "123456789100", email: "teste_teste@teste.com", name: "Maiqui Tomé", password: "123456"}

      iex> {:ok, user_schema} = Cuidapet.create_user(user_params)

      iex> {:ok, _user_schema} = Cuidapet.Users.Get.by_email(user_schema.email)

  """
  @spec by_email(String.t) ::
          {:error, %{result: String.t, status: :not_found}}
          | {:ok, User.t}

  def by_email(email) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, Error.build_user_not_found()}
      user_schema -> {:ok, user_schema}
    end
  end
end
