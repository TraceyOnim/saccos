defmodule Saccos.Farmer.Account do
  @moduledoc """
  This module contains the farmer context.It entails operations such as create, delete, update

  """
  alias Saccos.Farmer
  alias Saccos.Repo

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
end
