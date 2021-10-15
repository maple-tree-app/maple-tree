defmodule MapleTreeWeb.NewShoppingListLive do
  use MapleTreeWeb, :live_view

  alias Phoenix.View
  alias MapleTreeWeb.Helpers.LiveHelpers
  alias MapleTree.Groups.ShoppingList

  @impl true
  def mount(_params, session, socket) do
    socket = socket |> LiveHelpers.init(session) |> assign(changeset: apply_changeset())
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    View.render(MapleTreeWeb.ShoppingListView, "new.html", assigns)
  end

  defp apply_changeset(attrs \\ %{}) do
    ShoppingList.changeset(%ShoppingList{}, attrs)
  end


end
