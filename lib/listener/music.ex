defmodule Listener.Music do
  use Ecto.Schema
  import Ecto.Changeset
  alias Listener.Playlist
  alias Listener.Comment

  schema "musics" do
    field :link, :string
    field :reddit_identification, :string
    field :title, :string

    many_to_many :playlists, Playlist, join_through: "playlists_musics"
    has_many :comments, Comment
    timestamps()
  end

  @doc false
  def changeset(music, attrs) do
    music
    |> cast(attrs, [:title, :link, :reddit_identification])
    |> validate_required([:title, :link, :reddit_identification])
  end
end
