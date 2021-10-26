defmodule MapleTreeWeb.JoinGroupLive do
  use MapleTreeWeb, :live_view

  alias Phoenix.View
  alias MapleTree.Groups

  on_mount MapleTreeWeb.Helpers.InitAssigns

  @impl true
  def mount(%{"code" => invite_code}, _session, socket) do
    {:ok, socket |> assign(group: Groups.get_group_by_invite_code(invite_code))}
  end

  @impl true
  def render(assigns) do
    View.render(MapleTreeWeb.GroupsView, "join.html", assigns)
  end

  @impl true
  def handle_event("join-group", _, socket) do
    Groups.add_user(socket.assigns.group.id, socket.assigns.current_user.id)

    {:noreply,
     push_redirect(socket, to: Routes.groups_details_path(socket, :show, socket.assigns.group.id))}
  end
end
