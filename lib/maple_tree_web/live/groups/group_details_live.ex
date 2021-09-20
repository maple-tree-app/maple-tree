defmodule MapleTreeWeb.GroupsDetailsLive do
  use MapleTreeWeb, :live_view

  alias Phoenix.View
  alias MapleTreeWeb.Helpers.LiveHelpers
  alias MapleTree.Groups

  @impl true
  def mount(%{"id" => group_id}, session, socket) do
    socket = socket |> LiveHelpers.init(session) |> assign(group_id: group_id)
    {:ok, handle_load(socket)}
  end

  @impl true
  def render(assigns) do
    View.render(MapleTreeWeb.GroupsView, "show.html", assigns)
  end

  def handle_load(socket) do
    user_id = socket.assigns.current_user.id
    group_id = socket.assigns.group_id

    socket = case Groups.user_belongs_to_group?(socket.assigns.group_id, user_id) do
      true -> socket |> assign(:group, Groups.get_group(group_id, user_id))
      false -> socket
        |> put_flash(:error, "the group you're looking for doesn't exist")
        |> push_redirect(to: Routes.groups_page_path(socket, :index))
    end
    IO.inspect(socket)
    socket
  end

end
