defmodule Cuidapet.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table :users do
      # O Ecto gera automaticamento o ID

      add :cpf, :string
      add :cep, :string
      add :email, :string
      add :password_hash, :string
      add :registration_type, :registration_type
      add :ios_token, :string
      add :android_token, :string
      add :refresh_token, :string
      add :avatar_image, :string
      add :social_id, :string

      # inserted_at updated_at
      timestamps()
    end

    # create index("users", [:email], unique: true)
    create unique_index(:users, [:cpf])
    create unique_index(:users, [:email])

    # INDEX PARA O PAR (email e cpf)
    # create unique_index(:users, [:email, :cpf])
  end
end
