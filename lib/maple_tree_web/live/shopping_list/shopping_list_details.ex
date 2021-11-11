defmodule MapleTreeWeb.ShoppingListDetailsLive do
  use MapleTreeWeb, :live_view
  alias Phoenix.View
  alias MapleTree.Access.Groups

  on_mount MapleTreeWeb.Helpers.InitAssigns

  @impl true
  def mount(%{"shopping_list_id" => list_id}, _session, socket) do
    IO.inspect(Groups.get_shopping_list(list_id))
    case connected?(socket) do
      false -> {:ok, assign(socket, :loaded, false)}
      true ->  {:ok, assign(socket, loaded: true, shopping_list: Groups.get_shopping_list(list_id))}
    end
  end

  @impl true
  def render(assigns), do: View.render(MapleTreeWeb.ShoppingListView, "show.html", assigns)

end
