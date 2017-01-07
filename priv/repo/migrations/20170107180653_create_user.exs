defmodule Login.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password_encriptado, :string

      timestamps()
    end

  end
end
