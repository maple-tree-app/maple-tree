defmodule MapleTree.Groups.Group do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "groups" do
    field :color, :string
    field :description, :string
    field :name, :string
    field :image_url, :string

    many_to_many :users, MapleTree.Users.User, join_through: MapleTree.Groups.UserGroup
    has_many :users_groups, MapleTree.Groups.UserGroup

    timestamps()
  end

  @doc false
  def changeset(%MapleTree.Groups.Group{} = group, attrs) do
    group
    |> cast(attrs, [:name, :color, :description, :image_url])
    |> validate_required([:name])
  end
end
