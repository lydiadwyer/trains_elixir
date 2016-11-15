defmodule TrainsElixir.PageController do
  use TrainsElixir.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
