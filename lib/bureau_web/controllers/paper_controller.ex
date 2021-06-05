defmodule BureauWeb.PaperController do
  use BureauWeb, :controller
  alias BureauWeb.Router.Helpers, as: Routes
  alias Bureau.{Pile, Arxiv}
  require Logger

  def index(conn, %{"url" => url}) do
    id = Arxiv.match_paper_id(url)
    redirect(conn, to: Routes.paper_path(BureauWeb.Endpoint, :show, id))
  end

  def show(conn, %{"id" => id}) do
    if Arxiv.paper_exists?(id) do
      case Pile.find(id) do
        nil -> fetch_from_sisyphe(conn, id)
        paper -> handle_paper_status(conn, paper)
      end
    else
      render(conn, "notfound.html", id: id, title: "Not found")
    end
  end

  defp fetch_from_sisyphe(conn, id) do
    case Pile.insert(id) do
      {:ok, paper} -> handle_sisyphe_response(conn, paper, Pile.poke_sisyphe(id)) 
      {:error, _} -> render(conn, "status.html", paper: Pile.find(id))
    end
  end

  defp handle_sisyphe_response(conn, paper, %{status_code: code, body: body}) do
    case code do
      200 -> handle_paper_status(conn, body |> Jason.decode!() |> Pile.update())
      202 -> render(conn, "status.html", paper: paper)
    end
  end

  defp handle_paper_status(conn, paper) do
    if paper.status == "success" do
      conn 
      |> put_layout("paper.html") 
      |> render("show.html", paper: paper)
    else
      render(conn, "status.html", paper: paper)
    end
  end

  # Sisyphe webhook
  def create(conn, params) do
    Pile.update(params)
    BureauWeb.Endpoint.broadcast("render:#{params["arxiv_id"]}", "render_finish", %{})
    send_resp(conn, 200, "OK")
  end

end
