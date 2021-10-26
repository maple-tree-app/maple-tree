defmodule MapleTreeWeb.NewGroupPageLive do
  use MapleTreeWeb, :live_view

  alias Phoenix.View
  alias MapleTree.Groups

  on_mount MapleTreeWeb.Helpers.InitAssigns

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, :changeset, apply_changeset())
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    View.render(MapleTreeWeb.GroupsView, "new.html", assigns)
  end

  @impl true
  def handle_event("save", %{"group" => group_params}, socket) do
    case Groups.create_group(group_params, socket.assigns.current_user.id) do
      {:ok, group} ->
        {:noreply,
         socket
           |> put_flash(:info, Gettext.dgettext(MapleTreeWeb.Gettext, "groups", "group has been created"))
           |> push_redirect(to: Routes.groups_details_path(socket, :show, group.id))}

      {:error, changeset} ->
        {:noreply,
         socket |> put_flash(:error, "something went wrong") |> assign(changeset: changeset)}
    end
  end

  @impl true
  def handle_event("validate", %{"group" => group_params}, socket) do
    {:noreply, assign(socket, :changeset, apply_changeset(group_params))}
  end

  defp apply_changeset(attrs \\ %{}) do
    Groups.create_group_changeset(attrs)
  end
end
