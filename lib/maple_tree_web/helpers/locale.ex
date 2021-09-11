defmodule MapleTreeWeb.Helpers.Locale do
  def get_locale_from_conn(conn) do
    case Plug.Conn.get_req_header(conn, "accept-language") do
      [accept] -> find_most_suitable_locale(accept)
      _ -> nil
    end
  end

  def find_most_suitable_locale(accept) do
    known_locales = Gettext.known_locales(MapleTreeWeb.Gettext)
    locale = Enum.find(accept_language_to_list(accept), &(Enum.member?(known_locales, &1)))
    locale
  end

  defp accept_language_to_list(accept) do
    Regex.replace(~r/;q=[0-9].[0-9]|\*| /, accept, "")
      |> String.split(",")
      |> Enum.filter(&(&1 != ""))
  end
end
