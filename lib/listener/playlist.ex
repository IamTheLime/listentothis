defmodule Listener.Playlist do
  use Ecto.Schema
  import Ecto.Changeset
  alias Listener.User
  alias Listener.Music

  schema "playlists" do
    field :name, :string
    field :description, :string

    many_to_many :musics, Music, join_through: "playlists_musics"
    belongs_to :user, User
    timestamps()
  end

  @doc false
  def changeset(playlist, attrs) do
    playlist
    |> cast(attrs, [])
    |> validate_required([])
  end

end
