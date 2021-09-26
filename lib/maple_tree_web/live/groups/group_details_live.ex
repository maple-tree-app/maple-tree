defmodule MapleTreeWeb.GroupsDetailsLive do
  use MapleTreeWeb, :live_view

  alias Phoenix.View
  alias MapleTreeWeb.Helpers.LiveHelpers
  alias MapleTree.Groups

  @impl true
  def mount(%{"id" => group_id}, session, socket) do
    socket = socket |> LiveHelpers.init(session) |> assign(group_id: group_id, invite_dropdown_open?: false, invite_code: nil)
    {:ok, handle_load(socket)}
  end

  @impl true
  def render(assigns) do
    View.render(MapleTreeWeb.GroupsView, "show.html", assigns)
  end

  def handle_load(socket) do
    %{user_id: user_id, group_id: group_id} = get_user_and_group_id(socket)

    case Groups.user_belongs_to_group?(socket.assigns.group_id, user_id) do
      true -> assign(socket, :group, Groups.get_group(group_id, user_id))
      false -> socket
        |> put_flash(:error, "the group you're looking for doesn't exist")
        |> push_redirect(to: Routes.groups_page_path(socket, :index))
    end
  end

  @impl true
  def handle_event("handle_invite_button_click", _params, socket) when(socket.assigns.invite_code != nil), do: {:noreply, assign(socket, :invite_dropdown_open?, !socket.assigns.invite_dropdown_open?)}

  @impl true
  def handle_event("handle_invite_button_click", _params, socket) do
    %{user_id: user_id, group_id: group_id} = get_user_and_group_id(socket)
    {:ok, invite} = Groups.generate_invite_code(group_id, user_id)
    {:noreply, assign(socket, invite_code: invite.invite_code, invite_dropdown_open?: true)}
  end

  @impl true
  def handle_event("close_invite_button_dropdown", _, socket), do: {:noreply, assign(socket, :invite_dropdown_open?, false)}

  defp get_user_and_group_id(%{assigns: assigns}), do: %{user_id: assigns.current_user.id, group_id: assigns.group_id}


end
