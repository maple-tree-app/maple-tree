defmodule MapleTreeWeb.NewShoppingListLive do
  use MapleTreeWeb, :live_view

  alias Phoenix.View
  alias MapleTreeWeb.Helpers.LiveHelpers
  alias MapleTree.Groups
  alias MapleTree.Schemas.Groups.ShoppingList

  @impl true
  def mount(%{"group_id" => group_id}, session, socket) do
    socket = socket |> LiveHelpers.init(session) |> assign(changeset: apply_changeset(), group: Groups.get_group(group_id))
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    View.render(MapleTreeWeb.ShoppingListView, "new.html", assigns)
  end

  @impl true
  def handle_event("validate", %{"shopping_list" => shopping_list}, socket) do
    IO.inspect shopping_list
    {:noreply, socket}
  end

  @impl true
  def handle_event("save", asd, socket) do
    IO.inspect asd
    {:noreply, socket}
  end

  defp apply_changeset(attrs \\ %{}) do
    ShoppingList.changeset(%ShoppingList{}, attrs)
  end


end
