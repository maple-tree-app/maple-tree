defmodule MapleTree.Schemas.Groups.ShoppingItem do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "shopping_items" do
    field :name, :string
    field :detail, :string
    field :quantity, :integer
    field :is_collapsed, :boolean, default: false, virtual: true

    belongs_to :group, MapleTree.Schemas.Groups.Group, type: :binary_id
    belongs_to :shopping_list, MapleTree.Schemas.Groups.ShoppingList, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(shopping_item, attrs) do
    shopping_item
      |> cast(attrs, [:name, :quantity, :detail])
      |> validate_required([:name, :quantity])
      |> foreign_key_constraint(:shopping_list_id)
  end
end
