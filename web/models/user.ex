defmodule Login.User do
  use Login.Web, :model
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0, hashpwsalt: 1]

  schema "users" do
    field :email, :string
    field :password_encriptado, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> changeset_new(params)
    |> encriptar
  end

  def changeset_new(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_length(:password, min: 7)
  end

  defp encriptar(%Ecto.Changeset{valid?: true, changes: %{password: pass}} = changeset) do
      changeset
        |> put_change(:password_encriptado, hashpwsalt(pass))
  end

  defp encriptar(changeset) do
    changeset
  end

  def validate_login(struct, params) do
    struct
    |> changeset_new(params)
    |> do_validate_login
  end

  defp do_validate_login(%Ecto.Changeset{valid?: false} = changeset) do
    IO.inspect changeset
    {:error, changeset}

  end

  defp do_validate_login(%Ecto.Changeset{valid?: true, changes: %{email: email, password: pass}} = changeset) do
    Login.Repo.get_by(Login.User, email: email)
      |> existe_usuario?(changeset, pass)
  end

  defp existe_usuario?(nil, changeset, _pass) do
    {:error, changeset |> add_error(:email, "No existe el usuario")}
  end

  defp existe_usuario?(%Login.User{} = user, changeset, passw) do
    checkpw(passw, user.password_encriptado)
    |> verificar_password(user, changeset)
  end

  defp verificar_password(true, user, _changeset) do
    {:ok, user}
  end

  defp verificar_password(false, _user, changeset) do
    dummy_checkpw()
    {:error, changeset |> add_error(:password, "Tu no eres tu")}
  end
end
