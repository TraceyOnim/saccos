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
      "phone_number" => "254718539545",
      "nationality" => "Kenyan",
      "location" => "Nairobi",
      "dob" => %{"day" => 18, "month" => 09, "year" => 1996}
    }

    valid_attr2 = %{
      "first_name" => "second",
      "last_name" => "last",
      "national_id" => "1234566",
      "phone_number" => "254718539543",
      "nationality" => "Kenyan",
      "location" => "Nairobi",
      "dob" => %{"day" => 18, "month" => 09, "year" => 1996}
    }

    invalid_attr = %{}

    [valid_attr: valid_attr, invalid_attr: invalid_attr, valid_attr2: valid_attr2]
  end

  test "changeset has valid attributes", %{valid_attr: valid_attr} do
    changeset = Farmer.changeset(%Farmer{}, valid_attr)
    assert changeset.valid?
    assert {:ok, farmer} = Account.create_farmer(%Farmer{}, valid_attr)
  end

  test "farmer is created", %{valid_attr: valid_attr} do
    {:ok, farmer} = Account.create_farmer(%Farmer{}, valid_attr)
    assert farmer.first_name == "first"
    assert farmer.last_name == "last"
  end

  test "first_name is required", %{valid_attr: valid_attr} do
    attr = %{valid_attr | "first_name" => ""}
    assert {:error, changeset} = Account.create_farmer(%Farmer{}, attr)
  end

  test "first_name must be of minimum length of 3", %{valid_attr: valid_attr} do
    attr = %{valid_attr | "first_name" => "to"}
    assert {:error, changeset} = Account.create_farmer(%Farmer{}, attr)
  end

  test "registered_farmer_count/0 returns the total number of registered farmers", %{
    valid_attr: valid_attr,
    valid_attr2: valid_attr2
  } do
    {:ok, _farmer1} = Account.create_farmer(%Farmer{}, valid_attr)
    {:ok, _farmer2} = Account.create_farmer(%Farmer{}, valid_attr2)
    assert Account.registered_farmer_count() == 2
  end

  test "birthday_content_message/0 returns a message of farmer's birthday", %{
    valid_attr: valid_attr
  } do
    {:ok, farmer} = Account.create_farmer(%Farmer{}, valid_attr)

    date = Date.utc_today()

    if farmer.dob.month == date.month and farmer.dob.day == date.day do
      assert Account.birthday_content_message() ==
               "Happy 23 Birthday!!"
    else
      assert Account.birthday_content_message() ==
               ""
    end
  end
end
