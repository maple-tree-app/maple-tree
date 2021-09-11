defmodule MapleTreeWeb.GroupsPageLive do
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
    View.render(MapleTreeWeb.GroupsView, "index.html", assigns)
  end

end
