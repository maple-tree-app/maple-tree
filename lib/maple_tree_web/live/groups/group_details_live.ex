defmodule MapleTreeWeb.GroupsDetailsLive do
  use MapleTreeWeb, :live_view

  alias Phoenix.View
  alias MapleTree.Groups

  on_mount MapleTreeWeb.Helpers.InitAssigns


  @impl true
  def mount(%{"group_id" => group_id}, _session, socket) do
    socket =  case connected?(socket) do
      false -> assign(socket, loading?: true)
      true -> socket
        |> assign(group_id: group_id, loading?: false, invite_dropdown_open?: false, invite_code_link: nil)
        |> handle_load()
    end

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    View.render(MapleTreeWeb.GroupsView, "show.html", assigns)
  end

  # EVENTS
  @impl true
  def handle_event("handle_invite_button_click", _params, %{assigns: %{invite_code_link: invite_code_link}} = socket)
    when (invite_code_link != nil),
    do: {:noreply, assign(socket, :invite_dropdown_open?, !socket.assigns.invite_dropdown_open?)}


  @impl true
  def handle_event("handle_invite_button_click", _params, socket) do
    %{user_id: user_id, group_id: group_id} = get_user_and_group_id(socket)
    invite = build_invite_code_link(Groups.get_invite_code_valid_for_7_days(group_id, user_id), socket)

    {:noreply, assign(socket, invite_code_link: invite, invite_dropdown_open?: true)}
  end

  @impl true
  def handle_event("go_to_shopping_list", %{"id" => id}, socket) do
    {:noreply, push_redirect(socket, to: Routes.shopping_list_details_path(socket, :show, socket.assigns.group.id, id))}
  end

  @impl true
  def handle_event("close_invite_button_dropdown", _, socket),
    do: {:noreply, assign(socket, :invite_dropdown_open?, false)}

  @impl true
  def handle_event("click_section", %{"section" => section}, socket) do
    {:noreply,
     update(socket, :section_open_control, fn control ->
       Map.put(control, section, !control[section])
     end)}
  end

  # PRIVATE FUNCTIONS
  defp get_user_and_group_id(%{assigns: assigns}),
    do: %{user_id: assigns.current_user.id, group_id: assigns.group_id}

  defp build_invite_code_link({:ok, invite}, socket),
    do: MapleTreeWeb.Endpoint.url() <> Routes.join_group_path(socket, :join, invite.invite_code)

  defp handle_load(socket) do
    %{user_id: user_id, group_id: group_id} = get_user_and_group_id(socket)

    group = Groups.get_group(group_id, user_id)
    assign(socket,
      group: group,
      section_open_control: %{"shopping_lists" => true},
      shopping_lists: Groups.get_group_shopping_lists(group.id)
    )
  end
end
