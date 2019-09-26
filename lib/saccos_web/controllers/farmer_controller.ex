defmodule SaccosWeb.FarmerController do
  use SaccosWeb, :controller

  alias Saccos.Farmer
  alias Saccos.Farmer.Account

  plug :authenticate when action in [:index]

  def new(conn, _params) do
    changeset = Account.change_farmer(%Farmer{})
    render(conn, "new.html", changeset: changeset)
  end

  def index(conn, _params) do
    total_farmer = Account.registered_farmer_count()
    render(conn, "index.html", total_farmer: total_farmer)
  end

  def create(conn, %{"farmer" => farmer_params}) do
    case Account.register_farmer(%Farmer{}, farmer_params) do
      {:ok, farmer} ->
        conn
        |> SaccosWeb.Auth.login(farmer)
        |> put_flash(:info, "#{farmer.first_name} is successfully registered")
        |> redirect(to: Routes.farmer_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end
