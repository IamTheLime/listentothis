defmodule ListentothisWeb.MusicController do
    use ListentothisWeb, :controller

    def index(conn, _params) do
        render(conn, "index.html")
    end

    def show(conn, identification) do
        render conn, "show.htnl"
    end
    
end