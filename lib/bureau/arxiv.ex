defmodule Bureau.Arxiv do
  @arxiv_url_pattern ~r"(?:https://)?arxiv.org/[^/]+/(?<id>([a-zA-Z\-]+(?:\.[a-zA-Z]{2})?/\d{7}|\d+\.\d+)([vV]\d+)?)(\.pdf)?"

  def match_paper_id(url) do
    [id] = Regex.run(@arxiv_url_pattern, url, capture: ~w(id))
    id
  end

  def arxiv_metadata_url(id), do: "http://export.arxiv.org/oai2?verb=GetRecord&identifier=oai:arXiv.org:#{id}&metadataPrefix=arXivRaw"

  def get_metadata(id) do
    xml = fetch_metadata(id)
    metadata_keys = ~w(authors title date)
    metadata_values =
      metadata_keys
      |> Enum.map(fn key ->
        xml |> Floki.find(key) |> List.first() |> elem(2) |> List.first()
      end)

    Enum.zip(metadata_keys, metadata_values)
    |> Map.new()
  end


  defp fetch_metadata(id) do
    id
    |> arxiv_metadata_url()
    |> HTTPoison.get!()
    |> Map.get(:body)
    |> Floki.parse_document!()
  end

  def paper_exists?(id) do
    true
    # id
    # |> fetch_metadata()
    # |> Floki.find("error")
    # |> length() == 0
  end
end
