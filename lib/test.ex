defmodule Saccos.Test do
  use Ecto.Schema

  schema "tests" do
    field :title, :string
    field :score, :integer
  end
end
