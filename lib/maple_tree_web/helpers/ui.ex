defmodule MapleTreeWeb.Helpers.UI do
  @doc """
    builds the style 
  """
  def get_custom_button_style_string(hex) do
    "background-color: #{hex}; color: #{get_best_text_color_for_background(hex)};"
  end

  @doc """
    returns best hex value for a text given a hex for the backgreound
  """
  @spec get_best_text_color_for_background(S.string(), S.string(), S.string()) :: S.string()
  def get_best_text_color_for_background(hex, white \\ "#fff", black \\ "#000") do
    {:ok, %{r: r, g: g, b: b}} = get_rgb_from_hex(hex)

    if r * 0.299 + g * 0.587 + b * 0.114 > 186 do
      black
    else
      white
    end
  end

  defp get_rgb_from_hex(hex) do
    case Regex.replace(~r/#(?=[a-fA-F0-9])/, hex, "")
         |> String.graphemes()
         |> Enum.chunk_every(2)
         |> Enum.map(fn hex -> Enum.join(hex) |> Integer.parse(16) |> elem(0) end) do
      [r, g, b] -> {:ok, %{r: r, g: g, b: b}}
      _ -> {:error, "not a valid hex!"}
    end
  end
end
