defmodule Cuidapet.Users.Create do
  alias Cuidapet.{Error, Repo, Users.User}

  @type user_params :: %{
          address: String.t(),
          age: integer,
          cep: String.t(),
          cpf: String.t(),
          email: String.t(),
          name: String.t(),
          password: String.t()
        }

  @doc """
  Inserts an user into the database.

  ## Examples

      iex> user_params = %{
        cpf: "03112801024",
        cep: "95270000",
        email: "maiquitome@gmail.com",
        password: "123456",
        registration_type: "FACEBOOK",
        ios_token: "",
        android_token: "",
        refresh_token: "",
        avatar_image: "",
        social_id: ""
      }

      iex> Cuidapet.Users.Create.call(user_params)
      {:ok, %Cuidapet.User{}}

  """
  @spec call(user_params()) ::
          {:error,
           %Error{
             result: Ecto.Changeset.t() | String.t() | atom(),
             status: :bad_request | :not_found
           }}
          | {:ok, User.t()}

  def call(%{} = params) do
    # o nil não precisaria colocar porque já é nil por padrão
    # cep = Map.get(params, "cep", nil)

    changeset = User.changeset(params)

    with {:ok, %User{}} <- User.build(changeset),
        #  {:ok, %{} = _cep_info} <- client().get_cep_info(cep),
         {:ok, %User{}} = user <- Repo.insert(changeset) do
      user
    else
      {:error, %Error{}} = error -> error
      {:error, result} -> {:error, Error.build(:bad_request, result)}
    end
  end

  def call(_anything), do: {:error, "Enter the data in a map format"}

  # defp client do
  #   :Cuidapet
  #   |> Application.fetch_env!(__MODULE__)
  #   |> Keyword.get(:via_cep_adapter)
  # end
end
