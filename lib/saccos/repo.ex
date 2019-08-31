defmodule Saccos.Repo do
  use Ecto.Repo,
    otp_app: :saccos,
    adapter: Ecto.Adapters.Postgres
end
