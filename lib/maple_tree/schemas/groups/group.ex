defmodule MapleTree.Schemas.Groups.Group do
  @moduledoc """
    group entity module
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "groups" do
    field :color, :string, default: "#ef4343"
    field :description, :string
    field :name, :string
    field :image_url, :string
    field :members_count, :integer, virtual: true

    many_to_many :users, MapleTree.Schemas.Users.User,
      join_through: MapleTree.Schemas.Groups.UserGroup

    has_many :users_groups, MapleTree.Schemas.Groups.UserGroup, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(%MapleTree.Schemas.Groups.Group{} = group, attrs) do
    group
    |> cast(attrs, [:name, :color, :description, :image_url])
    |> validate_required([:name])
  end
end
