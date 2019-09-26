defmodule SaccosWeb.Auth do
  import Plug.Conn

  alias Saccos.Farmer.Account

  def init(opts), do: opts

  def call(conn, _opts) do
    farmer_id = get_session(conn, :farmer_id)
    farmer = farmer_id && Account.get_farmer(farmer_id)
    assign(conn, :current_user, farmer)
  end

  def login(conn, farmer) do
    conn
    |> assign(:current_user, farmer)
    |> put_session(:farmer_id, farmer.id)
    |> configure_session(renew: true)
  end

  def login_by_email_and_pass(conn, email, given_pass) do
    case Account.authenticate_by_email_and_pass(email, given_pass) do
      {:ok, farmer} -> {:ok, login(conn, farmer)}
      {:error, :unauthorized} -> {:error, :unauthorized, conn}
      {:error, :not_found} -> {:error, :not_found, conn}
    end
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end
end
