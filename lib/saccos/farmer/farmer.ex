defmodule Saccos.Farmer do
  @moduledoc """
  This module entails the farmer schema.It checks integrity of external data provided through changeset before been inserted to db,
  the changeset will raise an error incase there is a violation of validation or a known constraint

  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Saccos.Accounts.Credential

  schema "farmers" do
    field :first_name, :string
    field :last_name, :string
    field :national_id, :string
    field :phone_number, :string
    field :nationality, :string
    field :location, :string
    field :dob, :date
    field :nok_first_name, :string
    field :nok_last_name, :string
    field :nok_national_id, :string
    field :nok_phone_number, :string
    field :nok_dob, :date
    has_one :credential, Credential

    timestamps()
  end

  def changeset(farmer, attr \\ %{}) do
    farmer
    |> cast(attr, [
      :first_name,
      :last_name,
      :national_id,
      :phone_number,
      :nationality,
      :dob,
      :nok_dob,
      :nok_national_id,
      :location
    ])
    |> validate_required([:first_name, :last_name])
    |> validate_length(:first_name, min: 3, max: 10)
    |> validate_field_formats()
    |> validate_constraints()
  end

  def validate_constraints(changeset) do
    changeset
    |> check_constraint(:dob,
      name: :minimum_farmer_age,
      message: "you must be atleast 18 years and above to register as a farmer"
    )
    |> check_constraint(:dob,
      name: :maximum_farmer_age,
      message: "you must not be above 70 years to register as a farmer"
    )
    |> check_constraint(:nok_dob,
      name: :minimum_nok_age,
      message: "nok must be atleast 18 years and above to be registered as nok"
    )
    |> check_constraint(:nok_dob,
      name: :maximum_nok_age,
      message: "nok must not be above 70 years to be registered as nok"
    )
    |> check_constraint(:national_id,
      name: :minimum_id_number_to_be_atleast_seven,
      message: "ID number must be atleast seven digits"
    )
    |> check_constraint(:national_id,
      name: :maximum_id_number_to_be_atmost_nine,
      message: "ID number must not exceed nine digits"
    )
    |> check_constraint(:nok_national_id,
      name: :minimum_nok_id_number_to_be_atleast_seven,
      message: "ID number must be atleast seven digits"
    )
    |> check_constraint(:nok_national_id,
      name: :maximum_nok_id_number_to_be_atmost_nine,
      message: "ID number must not exceed nine digits"
    )
    |> unique_constraint(:national_id, message: "farmer with that ID number already exists")
    |> unique_constraint(:nok_national_id, message: "nok with that ID number already exists")
    |> unique_constraint(:phone_number, message: "farmer with that phone_number already exists")
    |> unique_constraint(:nok_phone_number, message: "nok with that phone_number already exists")
  end

  def validate_field_formats(changeset) do
    changeset
    |> validate_format(:phone_number, ~r/^\+?\d{9,12}+$/,
      message: "Phone number doesn't look right"
    )
    |> validate_format(:nok_phone_number, ~r/^\+?\d{9,12}+$/,
      message: "Phone number doesn't look right"
    )
    |> validate_format(:first_name, ~r/^[a-zA-Z ]{3,}+$/,
      message: "Name should be at least 3 characters and must be letters of alphabet"
    )
    |> validate_format(:nok_first_name, ~r/^[a-zA-Z ]{3,}+$/,
      message: "Name should be at least 3 characters and must be letters of alphabet"
    )
    |> validate_format(:last_name, ~r/^[a-zA-Z ]{1,}+$/,
      message: "Name should be at least 1 characters and must be letters of alphabet"
    )
    |> validate_format(:nok_last_name, ~r/^[a-zA-Z ]{1,}+$/,
      message: "Name should be at least 1 characters and must be letters of alphabet"
    )
    |> validate_format(:national_id, ~r/^\d{7,10}+$/,
      message: "The national id number seems incorrect"
    )
    |> validate_format(:nok_national_id, ~r/^\d{7,10}+$/,
      message: "The national id number seems incorrect"
    )
  end

  def registration_changeset(farmer, params) do
    farmer
    |> changeset(params)
    |> cast_assoc(:credential, with: &Credential.changeset/2, required: true)
  end
end
