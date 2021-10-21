defmodule MapleTreeWeb.Helpers.LiveCommon do
  def apply do
    quote do
      def handle_info(:clear_flash, socket), do: {:noreply, clear_flash(socket)}
    end
  end
end
