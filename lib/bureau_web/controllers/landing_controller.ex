defmodule BureauWeb.LandingController do
  use BureauWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
