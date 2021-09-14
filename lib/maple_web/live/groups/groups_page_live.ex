defmodule MapleTreeWeb.GroupsPageLive do
  use MapleTreeWeb, :live_view

  alias Phoenix.View
  alias MapleTreeWeb.Helpers.LiveHelpers
  alias MapleTree.Groups

  @impl true
  def mount(_params, session, socket) do
    socket = socket |> LiveHelpers.init(session) |> get_groups
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    View.render(MapleTreeWeb.GroupsView, "index.html", assigns)
  end


  def get_groups(socket) do
    assign(socket, groups: Groups.get_groups(socket.assigns.current_user.id))
  end

end
