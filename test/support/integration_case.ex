defmodule SaccosWeb.IntegrationCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use SaccosWeb.ConnCase
      use PhoenixIntegration
    end
  end
end
