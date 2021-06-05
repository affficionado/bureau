defmodule BureauWeb.PaperView do
  use BureauWeb, :view

  def arxiv_pdf_url(id), do: "https://arxiv.org/pdf/#{id}"
end
