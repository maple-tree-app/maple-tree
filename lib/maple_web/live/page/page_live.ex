defmodule MapleWeb.PageLive do
  use MapleWeb, :live_view

  alias Phoenix.View
  alias MapleWeb.Helpers.LiveHelpers

  @impl true
  def mount(_params, session, socket) do
    socket = socket |> LiveHelpers.pre_build(session)
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    View.render(MapleWeb.PageView, "index.html", assigns)
  end

end
