defmodule Listentothis.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
        add :title, :string, size: 256
        add :description, :string, size: 2048
        add :upvotes, :integer
        add :downvotes, :integer
        add :date_created, :naive_datetime
        add :user_id, references(:users)
        add :music_id, references(:musics)

        timestamps()
    end
  end
end
