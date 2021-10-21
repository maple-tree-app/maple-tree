defmodule MapleTreeWeb.JoinGroupLive do
  use MapleTreeWeb, :live_view

  alias Phoenix.View
  alias MapleTreeWeb.Helpers.LiveHelpers
  alias MapleTree.Groups

  @impl true
  def mount(%{"code" => invite_code}, session, socket) do
    IO.inspect(Groups.get_group_by_invite_code(invite_code))

    {:ok,
     socket
     |> LiveHelpers.init(session)
     |> assign(group: Groups.get_group_by_invite_code(invite_code))}
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
