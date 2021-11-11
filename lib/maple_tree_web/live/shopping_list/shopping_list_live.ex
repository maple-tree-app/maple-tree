defmodule MapleTreeWeb.ShoppingListLive do
  use MapleTreeWeb, :live_view

  alias Phoenix.View


  on_mount MapleTreeWeb.Helpers.InitAssigns

  @impl true
  def mount(_params, _session, socket), do: {:ok, assign(socket, modal_open: false)}

  @impl true
  def render(assigns) do
    View.render(MapleTreeWeb.ShoppingListView, "index.html", assigns)
  end

  @impl true
  def handle_event("open_modal", _, socket) do
    {:noreply, assign(socket, modal_open: true)}
  end

  @impl true
  def handle_event("close_modal", _, socket) do
    {:noreply, assign(socket, modal_open: false)}
  end
end
