defmodule ListentothisWeb.UserView do
  use ListentothisWeb, :view
  alias ListentothisWeb.User

  def first_name(%{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end


  def last_name(%{name: name}) do
    name
    |> String.split(" ")
    |> List.last()
  end

  def username(%{username: username}) do
    username
  end

  def getID(user) do
    user.id
  end

end
