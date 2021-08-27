defmodule MapleWeb.PageLive do
  use MapleWeb, :live_view

  alias Phoenix.View

  @impl true
  def mount(_params, session, socket) do
    if locale = session["locale"] do
      Gettext.put_locale(MapleWeb.Gettext, locale)
    end
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    View.render(MapleWeb.PageView, "index.html", assigns)
  end

end
