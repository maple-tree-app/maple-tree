defmodule MapleWeb.Plugs.LiveView do
  import Plug.Conn

  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"ovo" => ovo}} = conn, _opts) do
      put_session(conn, :ovo, ovo)
 end

  def call(conn, _opts), do: delete_session(conn, :option1)
end
