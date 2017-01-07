defmodule Login.LayoutView do
  use Login.Web, :view

  def login?(conn) do
    Guardian.Plug.authenticated?(conn)
    |> render?(conn)
  end

  defp render?(false, conn) do
    render "login.html", conn: conn
  end

  defp render?(true, conn) do
    render "logout.html", conn: conn
  end
end
