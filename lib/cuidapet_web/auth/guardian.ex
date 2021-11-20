defmodule CuidapetWeb.Auth.Guardian do
  use Guardian, otp_app: :cuidapet

  alias Cuidapet.Users.User
  alias Cuidapet.Error
  alias Cuidapet.Users.Get, as: UserGet

  def subject_for_token(%User{id: sub}, _claims), do: {:ok, sub}

  # coloca o usuário dentro dos claims do JWTToken
  def resource_from_claims(%{} = claims) do
    claims
    |> Map.get("sub")
    |> UserGet.by_id()
  end

  def authenticate(%{"id" => user_id, "password" => password}) do
    with {:ok, %User{password_hash: hash} = user} <- UserGet.by_id(user_id),
      true <- Argon2.verify_pass(password, hash),
      {:ok, token, _claims} <- encode_and_sign(user) do
        {:ok, token}
    else
      false -> {:error, Error.build(:unauthorized, "Please verify your credentials")}
      any_error -> any_error
    end
  end

  def authenticate(_), do: {:error, Error.build(:bad_request, "Invalid or missing params")}
end
