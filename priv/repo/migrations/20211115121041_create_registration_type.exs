defmodule Cuidapet.Repo.Migrations.CreateRegistrationType do
  use Ecto.Migration

  def change do
    up_query = "CREATE TYPE registration_type AS ENUM ('FACEBOOK', 'GOOGLE', 'APPLE', 'APP')"

    down_query = "DROP TYPE registration_type"

    execute(up_query, down_query)
  end
end
