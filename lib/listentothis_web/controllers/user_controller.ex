defmodule ListentothisWeb.UserController do
  use ListentothisWeb, :controller
  import Listentothis.Repo

  def index(conn, _params) do
    # users = Repo.all(:users)
    render conn, "index.html"#, users: users
  end

  def show(conn, identification) do
    # user = Repo.get(:user, Map.get(identification, "id"))
    render conn, "show.html"#, user: user
  end

end
