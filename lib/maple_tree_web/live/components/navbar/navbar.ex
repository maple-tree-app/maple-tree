defmodule MapleTreeWeb.Live.Components.Navbar do
  use MapleTreeWeb, :live_component
  alias MapleTree.Util.Converters
  alias MapleTree.Users

  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def handle_event(
        "click_dark_mode",
        %{"theme_checkbox_mobile" => %{"toggle" => checkbox_value}},
        %{assigns: %{current_user: %{id: user_id}}} = socket
      ) do
    if connected?(socket), do: update_checkbox_theme(checkbox_value, user_id)
    {:noreply, socket}
  end

  @impl true
  def handle_event(
        "click_dark_mode",
        %{"theme_checkbox" => %{"toggle" => checkbox_value}},
        %{assigns: %{current_user: %{id: user_id}}} = socket
      ) do
    update_checkbox_theme(checkbox_value, user_id)
    {:noreply, socket}
  end

  def handle_event("click_dark_mode", _, socket), do: {:noreply, socket}

  defp update_checkbox_theme(checkbox_value, user_id) do
    theme =
      if Converters.string_to_boolean(checkbox_value) == true do
        "dark"
      else
        "light"
      end

    Task.start(fn -> Users.update_user_theme(user_id, theme) end)
  end

  def is_dark_theme_active(%{current_user: %{settings: settings}}), do: settings.theme == "dark"
  def is_dark_theme_active(_), do: false
end
