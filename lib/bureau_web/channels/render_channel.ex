defmodule BureauWeb.RenderChannel do
  use Phoenix.Channel

  def join("render:" <> id, _paylod, socket) do
    {:ok, socket}
  end

end

