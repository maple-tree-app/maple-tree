defmodule MapleTree.Schemas.Groups.ShoppingItem do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "shopping_items" do
    field :name, :string
    field :observation, :string
    field :quantity, :integer
    field :shopping_list_id, :binary_id

    belongs_to :group, MapleTree.Schemas.Groups.Group, type: :binary_id
    belongs_to :list, MapleTree.Schemas.Groups.ShoppingList, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(shopping_item, attrs) do
    shopping_item
    |> cast(attrs, [:name, :quantity, :observation])
    |> validate_required([:name, :quantity, :observation])
  end
end
