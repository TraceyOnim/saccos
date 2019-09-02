defmodule Saccos.Repo.Migrations.CreateFarmers do
  use Ecto.Migration

  def change do
    create table(:farmers) do
      add :first_name, :string
      add :last_name, :string
      add :national_id, :string
      add :phone_number, :string
      add :nationality, :string
      add :location, :string
      add :dob, :date
      add :nok_first_name, :string
      add :nok_last_name, :string
      add :nok_national_id, :string
      add :nok_phone_number, :string
      add :nok_dob, :date

      timestamps()
    end
  end
end
