defmodule MapleTreeWeb.ShoppingListDetailsLive do
  use MapleTreeWeb, :live_view
  alias Phoenix.View

  on_mount MapleTreeWeb.Helpers.InitAssigns

  @impl true
  def mount(%{"shopping_list_id" => list_id}, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns), do: View.render(MapleTreeWeb.ShoppingListView, "show.html", assigns)

  defp get_shopping_list(_id) do
    nil
  end

end
