defmodule Listentothis.Repo.Migrations.CreateMusics do
  use Ecto.Migration

  def change do
    create table("musics") do
      add :title, :string, size: 256
      add :link, :string, size: 2048 
      add :reddit_identification, :string
      
      timestamps()
    end
  end
end
