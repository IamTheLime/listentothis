defmodule ListentothisWeb.SessionController do
    use ListentothisWeb, :controller

    def new(conn, _) do
        render conn, "new.html"
    end

    def create(conn, %{"session" => %{"username" => user, "password" => pass}}) do
        case Listentothis.Auth.login_user_pass(conn, user, pass, repo: Listentothis.Repo) do
            {:ok, conn} ->
                conn 
                |> put_flash(:info, "Welcome back")
                |> redirect(to: page_path(conn, :index))
            {:error, _reason, conn} ->
                conn
                |> put_flash(:error, "Invalid username/password combination ")
                |> render("new.html")
        end
    end

    def delete(conn, _) do
        conn
        |> Listentothis.Auth.logout()
        |> redirect(to: page_path(conn, :index))
    end

end