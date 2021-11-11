defmodule MapleTreeWeb.Components  do
  def load_components() do 
    quote do
      import MapleTreeWeb.Components.Modal
      import MapleTreeWeb.Components.GroupCard
      import MapleTreeWeb.Components.GenericCard
      import MapleTreeWeb.Components.Thumbnail
      import MapleTreeWeb.Components.Icons
      import MapleTreeWeb.Components.Group.ShoppingListSection
      alias MapleTreeWeb.Components.ShoppingListDetailsTable
    end
  end
end
