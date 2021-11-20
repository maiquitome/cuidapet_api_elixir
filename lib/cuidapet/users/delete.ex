defmodule Cuidapet.Users.Delete do
  @moduledoc """
  Delete an user from the database.
  """

  alias Ecto.Changeset
  alias Cuidapet.{Error, Repo, Users.User}

  @spec call(binary) ::
          {:error, %{result: String.t(), status: :not_found}}
          | {:ok, %User{}}
          | {:error, %Changeset{}}
  @doc """
  Delete an user from the database.

  ## Examples

      iex> user_params = %{address: "Rua...", age: 28, cep: "12345678", cpf: "12345678910",
      email: "teste_teste@teste.com", name: "Maiqui Tomé", password: "123456"}

      iex> {:ok, %Cuidapet.User{} = user} = Cuidapet.create_user(user_params)

      iex> {:ok, %Cuidapet.User{}} = Cuidapet.Users.Delete.call(user.id)

  """
  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found()}
      user_schema -> Repo.delete(user_schema)
    end
  end
end
