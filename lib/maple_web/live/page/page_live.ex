defmodule MapleTreeWeb.PageLive do
  use MapleTreeWeb, :live_view

  alias Phoenix.View
  alias MapleTreeWeb.Helpers.LiveHelpers

  @impl true
  def mount(_params, session, socket) do
    socket = socket |> LiveHelpers.init(session)
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    View.render(MapleTreeWeb.PageView, "index.html", assigns)
  end

end
