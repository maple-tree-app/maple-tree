defmodule MapleTreeWeb.Components  do
  def load_components() do 
    quote do
      import MapleTreeWeb.Components.Modal
      import MapleTreeWeb.Components.GroupCard
      import MapleTreeWeb.Components.GenericCard
      import MapleTreeWeb.Components.Thumbnail
    end
  end
end
