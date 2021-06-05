defmodule Bureau.Pile do
  @moduledoc"""
  Local storage of papers
  """
  alias Bureau.{Repo, Paper, Arxiv, Processor}
  require Logger

  def find(paper_id) do
    Repo.get_by(Paper, arxiv_id: paper_id)
  end

  def insert(id) do
    metadata = Arxiv.get_metadata(id)
    %Paper{
      arxiv_id: id, 
      status: "rendering",
      title: metadata["title"],
      # date: metadata["date"]
    }
    |> Repo.insert()
  end

  def update(%{"arxiv_id" => id, "status" => status, "html" => html}) do 
    attrs = Map.put(Processor.run(html, id), :status, status)
    Repo.get_by!(Paper, arxiv_id: id)
    |> Paper.changeset(attrs)
    |> Repo.update!()
  end

  def poke_sisyphe(paper_id) do
    Application.get_env(:bureau, :sisyphe_url)
    |> Path.join("papers/#{paper_id}")
    |> HTTPoison.get!()
  end
end
