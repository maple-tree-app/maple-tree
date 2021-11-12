defmodule MapleTreeWeb.Components.ShoppingListDetailsTable do
  import Phoenix.LiveView.Helpers


  def main_table(assigns) do
    ~H"""
    <div class="rounded-md border border-black dark:border-gray-400 w-full h-40 grid grid-cols-3">
      <.add_new_item />
      <.add_new_item />
      <.add_new_item />
    </div>
    """
  end

  def add_new_item(assigns) do
    ~H"""
    <div class="flex items-center justify-center">Item</div>
    <div class="flex items-center justify-center">Quantity</div>
    <div class="flex items-center justify-center">Details</div>
    """
  end
end
