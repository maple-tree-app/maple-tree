defmodule MapleTreeWeb.Live.Components.Navbar do
  use MapleTreeWeb, :live_component

  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def handle_event("click_dark_mode", _evt, socket) do
    {:noreply, socket}
  end

end
