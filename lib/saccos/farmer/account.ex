defmodule Saccos.Farmer.Account do
  @moduledoc """
  This module contains the farmer context.It entails operations such as create, delete, update

  """
  import Ecto.Query
  alias Saccos.Farmer
  alias Saccos.Repo
  alias Saccos.Accounts.Credential

  @doc """
  change_farmer/1 invokes the function changeset/2 from module Saccos.Farmer. It returns a changeset.
  """
  @spec change_farmer(%Farmer{}) :: %Ecto.Changeset{}
  def change_farmer(%Farmer{} = farmer) do
    Farmer.changeset(farmer, %{})
  end

  @doc """
  This functions inserts a farmer to the database.
  Returns {:ok, struct} if farmer is inserted successfully or {:error, changeset} incase of validation or known constraint error
  """
  @spec create_farmer(%Farmer{}, map()) :: {:ok, %Farmer{}} | {:error, %Ecto.Changeset{}}
  def create_farmer(farmer, attr) do
    farmer
    |> Farmer.changeset(attr)
    |> Repo.insert()
  end

  def register_farmer(farmer, attr \\ %{}) do
    farmer
    |> Farmer.registration_changeset(attr)
    |> Repo.insert()
  end

  @doc """
  Returns the total number of registered farmers saved in the database
  """
  @spec registered_farmer_count() :: integer()
  def registered_farmer_count do
    Repo.aggregate(Farmer, :count, :id)
  end

  @doc """
  it fetches a single farmer struct from the db, where the primary key matches the given id.Returns nil if no result found.
  """
  @spec get_farmer(integer()) :: %Farmer{} | nil
  def get_farmer(farmer_id) do
    Farmer
    |> Repo.get(farmer_id)
  end

  @doc """
  This function contains birthday message, that farmers will receive when its their birthday
  """
  @spec birthday_content_message() :: String.t()
  def birthday_content_message() do
    date = Date.utc_today()
    query = from f in "farmers", select: f.dob

    query
    |> Repo.all()
    |> Enum.filter(fn dob -> dob.month == date.month and dob.day == date.day end)
    |> message()
  end

  defp message([dob]) do
    "Happy #{year_count(dob)} Birthday!!"
  end

  defp message([]) do
    ""
  end

  defp year_count(dob) do
    date = Date.utc_today()

    date
    |> Date.diff(dob)
    |> Integer.floor_div(360)
  end

  def change_credential(%Credential{} = credential) do
    Credential.changeset(credential, %{})
  end

  def get_user_by_email(email) do
    from(f in Farmer, join: c in assoc(f, :credential), where: c.email == ^email)
    |> Repo.one()
    |> Repo.preload(:credential)
  end

  def authenticate_by_email_and_pass(email, given_pass) do
    farmer = get_user_by_email(email)

    cond do
      farmer && Comeonin.Pbkdf2.checkpw(given_pass, farmer.credential.password_hash) ->
        {:ok, farmer}

      farmer ->
        {:error, :unauthorized}

      true ->
        Comeonin.Bcrypt.dummy_checkpw()
        {:error, :not_found}
    end
  end
end
