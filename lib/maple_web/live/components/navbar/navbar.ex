defmodule MapleTreeWeb.Live.Components.Navbar do
  use MapleTreeWeb, :live_component

  @impl true
  def mount(socket) do

    IO.inspect(socket.assigns)
    {:ok, assign(socket, :mobile_menu_open?, false)}
  end

  @impl true
  def handle_event("mobile-button", _value, socket) do
    {:noreply, assign(socket, :mobile_menu_open?, !Map.get(socket.assigns, :mobile_menu_open?))}
  end
end
