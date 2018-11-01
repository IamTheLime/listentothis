defmodule ListentothisWeb.PageController do
  use ListentothisWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
