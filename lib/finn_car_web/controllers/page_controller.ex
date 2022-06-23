defmodule FinnCarWeb.PageController do
  use FinnCarWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
