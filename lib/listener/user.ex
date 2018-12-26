defmodule Listener.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Listener.Playlist
  alias Listener.Comment

  schema "users" do
    field :name, :string
    field :password, :string
    field :username, :string
    field :email, :string

    has_many :playlists, Playlist
    has_many :comments, Comment
    timestamps()
  end

  def default_changeset(user, params\\%{}) do
    cast(user, params , [:name, :email, :username, :password])
  end

  @doc false
  def create_changeset(user, params) do
    user
    |> cast(params, [:name, :email, :username, :password])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> validate_required([:name, :email, :username, :password])
  end
end
