defmodule ListentothisWeb.UserController do
  use ListentothisWeb, :controller
  alias Listentothis.Repo
  alias Listener.User
  import IEx
  import Listentothis.Auth, only: [ authenticate_user: 2]

  plug :authenticate_user when action in [:index, :show]

  def index(conn, _params) do
    render conn, "index.html"
  end

  def show(conn, identification) do
    # user = Repo.get(:user, Map.get(identification, "id"))
    render conn, "show.html"#, user: user
  end

  def new(conn, _params) do
    changeset = User.default_changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def enter(conn, _params) do
    render conn, "enter.html"
  end

  def create(conn, %{"user" => user_parameters}) do
    changeset = User.create_changeset( %User{}, user_parameters)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> Listentothis.Auth.login(user)
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: user_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

end
