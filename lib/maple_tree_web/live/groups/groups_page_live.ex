defmodule MapleTreeWeb.GroupsPageLive do
  use MapleTreeWeb, :live_view

  alias Phoenix.View
  alias MapleTree.Groups

  on_mount MapleTreeWeb.Helpers.InitAssigns

  @impl true
  def mount(_params, _session, socket) do
    socket = get_groups(socket)
    {:ok, socket}
  end

  @impl true
  def render(assigns), do: View.render(MapleTreeWeb.GroupsView, "index.html", assigns)

  @impl true
  def handle_event("search", %{"user_input" => search_params}, socket) do
    {:noreply, get_groups(socket, search_params)}
  end

  @impl true
  def handle_event("click-group", %{"id" => group_id}, socket) do
    {:noreply, push_redirect(socket, to: Routes.groups_details_path(socket, :show, group_id))}
  end

  defp get_groups(socket, search_params \\ []) do
    groups = Groups.get_groups(socket.assigns.current_user.id, search_params)

    socket
    |> assign(groups: groups)
    |> assign_new(:has_groups, fn -> length(groups) > 0 end)
  end
end
