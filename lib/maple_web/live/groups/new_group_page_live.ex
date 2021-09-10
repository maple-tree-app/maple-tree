defmodule MapleTreeWeb.NewGroupPageLive do
  use MapleTreeWeb, :live_view

  alias Phoenix.View
  alias MapleTreeWeb.Helpers.LiveHelpers
  alias MapleTree.Groups

  @impl true
  def mount(_params, session, socket) do

    socket = LiveHelpers.init(socket, session)
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
      {:ok, _group} -> {:noreply, socket
        |> put_flash(:info, "group has been created")
        |> push_redirect(to: Routes.groups_page_path(socket, :index))}
      {:error, changeset} -> {:noreply, socket |> put_flash(:error, "something went wrong") |> assign(changeset: changeset)}
    end
  end

  @impl true
  def handle_event("validate", %{"group" => group_params}, socket) do
    IO.inspect(group_params)
    {:noreply, assign(socket, :changeset, apply_changeset(group_params))}
  end


  defp apply_changeset(attrs \\ %{}) do
    Groups.create_group_changeset(attrs)
  end

end
