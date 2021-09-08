defmodule MapleTree.Groups.Group do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "groups" do
    field :color, :string
    field :description, :string
    field :name, :string

    many_to_many :users, MapleTree.Groups.Group, join_through: MapleTree.Groups.UserGroup

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name, :color, :description])
    |> validate_required([:name, :color, :description])
  end
end
