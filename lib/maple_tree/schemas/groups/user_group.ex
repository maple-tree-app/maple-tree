defmodule MapleTree.Schemas.Groups.UserGroup do
  @moduledoc """
    user_group pivot table entity module
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users_groups" do
    field :is_admin, :boolean, default: false
    field :is_favorite, :boolean, default: false
    belongs_to :user, MapleTree.Schemas.Users.User, type: :binary_id
    belongs_to :group, MapleTree.Schemas.Groups.Group, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(%MapleTree.Schemas.Groups.UserGroup{} = user_group, attrs) do
    user_group
    |> cast(attrs, [:user_id, :is_admin, :group_id, :is_favorite])
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:group_id)
  end
end
