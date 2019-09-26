defmodule Saccos.Repo.Migrations.CreateTests do
  use Ecto.Migration

  def change do
    create table("tests") do
      add :title, :string
      add :score, :integer
    end
  end
end
