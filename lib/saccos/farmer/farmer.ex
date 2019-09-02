defmodule Saccos.Farmer do
  @moduledoc """
  This module entails the farmer schema

  """
  use Ecto.Schema
  import Ecto.Changeset

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
      :location
    ])
    |> validate_required([:first_name, :last_name])
  end
end
