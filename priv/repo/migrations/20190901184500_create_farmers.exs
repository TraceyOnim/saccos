defmodule Saccos.Repo.Migrations.CreateFarmers do
  use Ecto.Migration

  def change do
    create table(:farmers) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :national_id, :string, null: false
      add :phone_number, :string, null: false
      add :nationality, :string, null: false
      add :location, :string, null: false
      add :dob, :date, null: false
      add :nok_first_name, :string
      add :nok_last_name, :string
      add :nok_national_id, :string
      add :nok_phone_number, :string
      add :nok_dob, :date

      timestamps()
    end

    create constraint("farmers", :minimum_farmer_age, check: "date_part('year', age(dob)) > 17")
    create constraint("farmers", :maximum_farmer_age, check: "date_part('year', age(dob)) < 77")
    create constraint("farmers", :minimum_nok_age, check: "date_part('year', age(nok_dob)) > 17")
    create constraint("farmers", :maximum_nok_age, check: "date_part('year', age(nok_dob)) <77")

    create constraint("farmers", :minimum_id_number_to_be_atleast_seven,
             check: "length(national_id) > 6"
           )

    create constraint("farmers", :maximum_id_number_to_be_atmost_nine,
             check: "length(national_id) < 10"
           )

    create constraint("farmers", :minimum_nok_id_number_to_be_atleast_seven,
             check: "length(nok_national_id) > 6"
           )

    create constraint("farmers", :maximum_nok_id_number_to_be_atmost_nine,
             check: "length(nok_national_id) < 10"
           )

    create unique_index(:farmers, [:national_id])
    create unique_index(:farmers, [:nok_national_id])
    create unique_index(:farmers, [:phone_number])
    create unique_index(:farmers, [:nok_phone_number])
  end
end
