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

  @impl true
  def handle_event("search", %{"user_input" => search_params}, socket) do
    IO.inspect search_params
    {:noreply, get_groups(socket, search_params)}
  end

  def get_groups(socket, search_params \\ []) do
    assign(socket, groups: Groups.get_groups(socket.assigns.current_user.id, search_params))
  end

end
