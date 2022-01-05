defmodule MapleTreeWeb.Components.Icons do
  import Phoenix.LiveView.Helpers

  @doc """
  Arrow to indicate if a section is collapsed
  """
  def collapse_arrow(%{collapsed?: collapsed?} = assigns) do
    ~H"""
      <svg xmlns="http://www.w3.org/2000/svg" class={"#{assigns[:class]} #{get_animation_class(collapsed?)}"} fill="none" viewBox="0 0 24 24" stroke="currentColor"> <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" /> </svg>
    """
  end

  defp get_animation_class(false), do: "collapse-close"
  defp get_animation_class(true), do: "collapse-open"
end
