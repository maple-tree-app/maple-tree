defmodule MapleTreeWeb.ShoppingListDetailsLive do
  use MapleTreeWeb, :live_view

  on_mount MapleTreeWeb.Helpers.InitAssigns

  def mount(%{"shopping_list_id" => list_id}, _session, socket) do
    {:noreply, assign(socket, :shopping_list, get_shopping_list(list_id))}
  end


  defp get_shopping_list(_id) do
    nil
  end

end
