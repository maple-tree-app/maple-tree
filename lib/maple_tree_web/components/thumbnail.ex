defmodule MapleTreeWeb.Components.Thumbnail do
  import Phoenix.LiveView.Helpers
  import MapleTreeWeb.Helpers.UI
  use Phoenix.LiveComponent

  def render(%{name: name} = assigns) do
    color = Map.get(assigns, :color, '#F85C4D')
    class = Map.get(assigns, :class, "")
    text_class = Map.get(assigns, :text_class, "")
    if assigns[:image] != nil do
      ~H"""
      <img class={"maple-card__image #{class}"} src={@image} alt={name<>"_thumbnail"} />
      """
    else
      ~H"""
      <div class={"flex items-center justify-center w-40 maple-card__image #{class}"} style={"background-color: "<>color}>
        <h1
          class={"font-bold text-xl #{text_class}"}
          style={"color: "<>get_best_text_color_for_background(color)}
        >
        <%= get_initials(name) %>
      </h1>
      </div>
      """
    end
  end


  defp get_initials(name), do: 
    String.upcase(name)
      |> String.split
      |> Enum.take(3)
      |> Enum.map(&(String.at(&1, 0)))
      |> Enum.join()
end
