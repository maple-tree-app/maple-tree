defmodule MapleTreeWeb.Helpers.InitAssigns do
  @moduledoc """
  Ensures common assigns are applied to all LiveViews attaching this hook.
  """
  def on_mount(:default, _params, session, socket), do: {:cont, MapleTreeWeb.Helpers.LiveHelpers.init(socket, session)}
  
end
