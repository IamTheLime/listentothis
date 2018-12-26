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

  def error_sanitizer( %{errors: errors}, subfield) do
    subfield_error = errors |> List.keyfind( subfield, 0)
    if subfield_error != nil do
      case subfield do
        :username -> "Username " <> elem(elem(subfield_error,1), 0)
        :email -> "Email " <> elem(elem(subfield_error,1), 0)
        :name -> "Name " <> elem(elem(subfield_error,1), 0)
        :password -> "Password " <> elem(elem(subfield_error,1), 0)
      end
    end
  end

end
