defmodule MapleWeb.PathHelpers do

  def apply_class_when_current_route(conn, path, class) do
    if active_route?(conn, path),
      do: class,
      else: ""
  end

  defp active_route?(conn, path) do
    Path.join(["/" | conn.path_info]) == path
  end
end
