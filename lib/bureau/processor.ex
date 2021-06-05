defmodule Bureau.Processor do
  @moduledoc"""
  Prepares raw Sisyphe render to display on Bureau
  """

  def run(nil, _), do: %{}

  def run(html, id) do
    tree =
      html
      |> Floki.parse_document!()
      |> add_prefix_to_path(id)
    %{
      toc: tree |> find_tag(".ltx_TOC"),
      body: tree |> find_tag(".ltx_page_main") |> remove_footer(),
      links: tree |> find_tag("link"),
      styles: tree |> find_tag("style"),
      scripts: tree |> find_tag("script"),
    }
  end

  defp add_prefix_to_path(tree, id) do
    url = Application.get_env(:bureau, :sisyphe_url)
    tree
    |> Floki.find_and_update("link", fn
      {"link", [{"href", href} | attrs]} -> 
        {"link", [{"href", Path.join(url, href)} | attrs]}
      other -> other
    end)
    |> Floki.find_and_update("script", fn
      {"script", [{"src", src} | attrs]} -> 
        {"script", [{"src", Path.join(url, src)} | attrs]}
      other -> other
    end)
    |> Floki.find_and_update("img", fn
      {"img", [{"src", src} | attrs]} -> 
        {"img", [{"src", Path.join([url, "html", id, src])} | attrs]}
      other ->  other
    end)
  end  

  defp find_tag(tree, tag) do
    tree
    |> Floki.find(tag)
    |> Floki.raw_html()
  end

  defp remove_footer(tree) do
    tree
    |> Floki.filter_out(".ltx_page_footer")
    |> Floki.raw_html()
  end

end
