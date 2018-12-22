defmodule Listentothis.Repo.Migrations.CreatePlaylists do
  use Ecto.Migration

  def change do
    create table("playlists") do
      add :name, :string, size: 256
      add :description, :string, size: 2048
      add :user_id, references(:users)

      timestamps()
    end
  end
end
