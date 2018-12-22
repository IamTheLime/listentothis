defmodule Listener.PlaylistsMusics do
  use Ecto.Schema
  import Ecto.Changeset
  alias Listener.Playlist
  alias Listener.Music  

  schema "playlists_musics" do
    belongs_to :playlist, Playlist
    belongs_to :music, Music

    timestamps()
  end

  @doc false
  def changeset(playlists_musics, attrs) do
    playlists_musics
    |> cast(attrs, [])
    |> validate_required([])
  end
end
