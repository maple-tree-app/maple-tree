defmodule MapleTreeWeb.ShoppingListLive do
  use MapleTreeWeb, :live_view

  alias Phoenix.View
  alias MapleTreeWeb.Helpers.LiveHelpers

  @impl true
  def mount(_params, session, socket) do
    socket = socket |> LiveHelpers.pre_build(session)
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    View.render(MapleTreeWeb.ShoppingListView, "index.html", assigns)
  end

end
