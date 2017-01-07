defmodule Login.LoginController do
  use Login.Web, :controller
  alias Login.User

  def registro(conn, _params) do
    changeset = %User{} |> User.changeset_new()
    render conn, "registro.html", changeset: changeset
  end

  def post_registro(conn, %{"user" => user_params}) do
    changeset = %User{} |> User.changeset(user_params)
    case Repo.insert(changeset) do
        {:ok, user} ->
          conn
          |> Guardian.Plug.sign_in(user, :token)
          |> put_flash(:info, "Exito al registrarse.")
          |> redirect(to: page_path(conn, :index))
        {:error, changeset} ->
          render conn, "registro.html", changeset: changeset
    end
  end

  def logout(conn, _params) do
    conn
      |> Guardian.Plug.sign_out
      |> put_flash(:info, "Exito al desloguearse.")
      |> redirect(to: page_path(conn, :index))
  end

  def login(conn, _params) do
    changeset = %User{} |> User.changeset_new()
    render conn, "login.html", changeset: changeset
  end

  def post_login(conn, %{"user" => user_params}) do
    valid? = %User{} |> User.validate_login(user_params)
    case valid? do
        {:ok, user} ->
          conn
          |> Guardian.Plug.sign_in(user, :token)
          |> put_flash(:info, "Exito al registrarse.")
          |> redirect(to: page_path(conn, :index))
        {:error, changeset} ->
          render conn, "login.html", changeset: changeset
    end
  end
end
