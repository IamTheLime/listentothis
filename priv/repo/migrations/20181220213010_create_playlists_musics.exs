defmodule Listentothis.Repo.Migrations.CreatePlaylistsMusics do
  use Ecto.Migration

  def change do
    create table("playlists_musics") do
      add :playlist_id, references(:playlists)
      add :music_id, references(:musics)

      timestamps()
    end
  end
end
