defmodule MapleTreeWeb.NewShoppingListLive do
  use MapleTreeWeb, :live_view

  alias Phoenix.View
  alias MapleTreeWeb.Helpers.LiveHelpers
  alias MapleTree.Groups
  alias MapleTree.Schemas.Groups.ShoppingList

  @impl true
  def mount(%{"group_id" => group_id}, session, socket) do
    socket =
      socket
      |> LiveHelpers.init(session)
      |> assign(
        changeset: apply_changeset(),
        group: Groups.get_group(group_id)
      )

    {:ok, socket}
  end

  @impl true
  def render(assigns), do: View.render(MapleTreeWeb.ShoppingListView, "new.html", assigns)

  @impl true
  def handle_event("validate", %{"shopping_list" => shopping_list_attrs}, socket) do
    {:noreply, assign(socket, changeset: apply_changeset(shopping_list_attrs))}
  end

  @impl true
  def handle_event("save", %{"shopping_list" => shopping_list_attrs}, socket) do
    case Groups.create_shopping_list(shopping_list_attrs) do
      {:ok, _shopping_list} -> 
        {:noreply, socket
          |> put_flash(:info, Gettext.dgettext(MapleTreeWeb.Gettext, "shopping_list", "shopping list created"))
          |> push_redirect(to: Routes.groups_details_path(socket, :show, socket.assigns.group.id))}

      {:error, changeset} -> 
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp apply_changeset(attrs \\ %{}) do
    ShoppingList.changeset(%ShoppingList{}, attrs)
  end
end
