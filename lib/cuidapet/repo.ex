defmodule Cuidapet.Repo do
  use Ecto.Repo,
    otp_app: :cuidapet,
    adapter: Ecto.Adapters.Postgres
end
