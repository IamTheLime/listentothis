defmodule Listener.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Pbkdf2
  alias Listener.Playlist
  alias Listener.Comment

  schema "users" do
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :username, :string
    field :email, :string

    has_many :playlists, Playlist
    has_many :comments, Comment
    timestamps()
  end

  def default_changeset(user, params\\%{}) do
    cast(user, params , [:name, :email, :username])
    |> validate_length(:username, min: 1, max: 20)
  end

  @doc false
  def create_changeset(user, params) do
    user
    |> default_changeset(params)
    |> cast(params, [:password])
    |> validate_required([:name, :email, :username, :password])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> validate_length(:password, min: 6, max: 256)
    |> put_pass_hash
  end

  def put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} -> 
        put_change(changeset, :password_hash, Comeonin.Pbkdf2.hashpwsalt(pass))
        
        _ -> changeset
    end
  end

end
