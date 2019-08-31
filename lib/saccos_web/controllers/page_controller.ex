defmodule SaccosWeb.PageController do
  use SaccosWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
