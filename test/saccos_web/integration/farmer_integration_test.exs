defmodule SaccosWeb.FarmerIntegrationTest do
  use SaccosWeb.IntegrationCase

  test "admin can create farmer", %{conn: conn} do
    conn
    |> get(Routes.farmer_path(conn, :new))
    |> follow_form(
      %{
        farmer: %{
          first_name: "first",
          last_name: "last",
          national_id: "1234567",
          phone_number: "254718539545"
        }
      },
      %{method: "post"}
    )
    |> assert_response(html: "first is successfully registered")
  end
end
