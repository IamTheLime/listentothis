defmodule Listener.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Listener.User
  alias Listener.Music

  schema "comments" do
    field :date_created, :naive_datetime
    field :description, :string
    field :downvotes, :integer
    field :title, :string
    field :upvotes, :integer

    belongs_to :user, User
    belongs_to :music, Music
    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:title, :description, :date_created, :upvotes, :downvotes])
    |> validate_required([:title, :description, :date_created, :upvotes, :downvotes])
  end
end
