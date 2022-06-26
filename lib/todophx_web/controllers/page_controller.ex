defmodule TodophxWeb.PageController do
  use TodophxWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
