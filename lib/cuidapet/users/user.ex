defmodule Cuidapet.Users.User do
  use Ecto.Schema

  import Ecto.Changeset

  @required_fields [
    :cpf,
    :cep,
    :email,
    :password,
    :registration_type
  ]

  @fields_that_can_be_changed [
                                :ios_token,
                                :android_token,
                                :refresh_token,
                                :avatar_image,
                                :social_id
                              ] ++ @required_fields

  @primary_key {:id, :binary_id, autogenerate: true}

  @derive {Jason.Encoder, only: @fields_that_can_be_changed ++ [:id]}

  schema "users" do
    field :cpf, :string
    field :cep, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :registration_type, Ecto.Enum, values: [:FACEBOOK, :GOOGLE, :APPLE, :APP]
    field :ios_token, :string
    field :android_token, :string
    field :refresh_token, :string
    field :avatar_image, :string
    field :social_id, :string

    timestamps()
  end

  def build(changeset), do: apply_action(changeset, :insert)

  def changeset_to_update(struct, %{} = params) do
    changeset(struct, params, @required_fields -- [:password])
  end

  def changeset(struct \\ %__MODULE__{}, %{} = params, required_fields \\ @required_fields) do
    struct
    |> cast(params, @fields_that_can_be_changed)
    |> validate_required(required_fields)
    |> validate_length(:password, min: 6)
    |> validate_length(:cep, is: 8)
    |> validate_length(:cpf, is: 11)
    |> validate_format(:email, ~r/^[\w.!#$%&’*+\-\/=?\^`{|}~]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*$/i)
    |> unique_constraint(:email)
    |> unique_constraint(:cpf)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
