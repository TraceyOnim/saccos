defmodule SaccosWeb.FarmerController do
  use SaccosWeb, :controller

  alias Saccos.Farmer
  alias Saccos.Farmer.Account

  def new(conn, _params) do
    changeset = Account.change_farmer(%Farmer{})
    render(conn, "new.html", changeset: changeset)
  end

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def create(conn, %{"farmer" => farmer_params}) do
    case Account.create_farmer(%Farmer{}, farmer_params) do
      {:ok, farmer} ->
        conn
        |> put_flash(:info, "#{farmer.first_name} is successfully registered")
        |> redirect(to: Routes.farmer_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
