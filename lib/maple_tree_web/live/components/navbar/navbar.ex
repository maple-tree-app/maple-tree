defmodule MapleTreeWeb.Live.Components.Navbar do
  use MapleTreeWeb, :live_component
  import MapleTree.Users, only: [update_user_theme: 2]
  alias MapleTree.Util.Converters

  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def handle_event("click_dark_mode", %{"theme_checkbox" => %{"toggle" => theme_change}}, socket) do
    # MapleTree.Users.upda
    theme = if Converters.string_to_boolean(theme_change) == true do "dark" else "light" end
    IO.inspect(theme)
    case socket do
     %{assigns: %{current_user: %{id: id}}} -> IO.inspect(id)
      Task.start(fn -> update_user_theme(id, theme) end)
     _ -> nil
    end
    {:noreply, socket}
  end


end
