defmodule SaccosWeb.FarmerControllerTest do
  use SaccosWeb.ConnCase

  test "GET/farmers/new", %{conn: conn} do
    conn = get(conn, Routes.farmer_path(conn, :new))
    assert html_response(conn, 200) =~ "Register Farmer"
  end
end
