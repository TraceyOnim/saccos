defmodule Saccos.FarmerUnitTest do
  @moduledoc """
  This module contain unit test of the operations that entails the farmer
  """
  use Saccos.DataCase
  alias Saccos.Farmer
  alias Saccos.Farmer.Account

  setup do
    valid_attr = %{
      "first_name" => "first",
      "last_name" => "last",
      "national_id" => "1234567",
      "phone_number" => "254718539545"
    }

    invalid_attr = %{}

    [valid_attr: valid_attr, invalid_attr: invalid_attr]
  end

  test "changeset has valid attributes", %{valid_attr: valid_attr} do
    changeset = Farmer.changeset(%Farmer{}, valid_attr)
    assert changeset.valid?
  end
end
