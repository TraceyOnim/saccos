defmodule SaccosWeb.FarmerController do
  use SaccosWeb, :controller

  alias Saccos.Farmer
  alias Saccos.Farmer.Account

  def new(conn, _params) do
    changeset = Account.change_farmer(%Farmer{})
    render(conn, "new.html", changeset: changeset)
  end
end
