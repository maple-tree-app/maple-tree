defmodule MapleWeb.PageLive do
  use MapleWeb, :live_view

  alias Phoenix.View

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "", results: %{})}
  end

  @impl true
  def render(assigns) do
    View.render(MapleWeb.PageView, "index.html", assigns)
  end

end
