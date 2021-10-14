defmodule MapleTree.Groups.ShoppingList do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "shopping_lists" do
    field :description, :string
    field :image_url, :string
    field :name, :string

    belongs_to :group, MapleTree.Groups.Group, type: :binary_id
    has_many :items, MapleTree.Groups.ShoppingItem, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(shopping_list, attrs) do
    shopping_list
    |> cast(attrs, [:name, :image_url, :description, :group_id])
    |> validate_required([:name])
  end
end
