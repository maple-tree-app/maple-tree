defmodule MapleTreeWeb.Live.Components.GroupCard do
  use MapleTreeWeb, :live_component

  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def update(assigns, socket) do
    {:ok, assign(socket, Enum.map(assigns, fn {key, val} -> {key, val} end))}
  end
end
