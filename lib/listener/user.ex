defmodule Listener.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Listener.Playlist
  alias Listener.Comment

  schema "users" do
    field :name, :string
    field :password, :string
    field :username, :string

    has_many :playlists, Playlist
    has_many :comments, Comment
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username, :password])
    |> validate_required([:name, :username, :password])
  end
end
