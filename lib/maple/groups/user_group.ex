defmodule MapleTree.Groups.UserGroup do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users_groups" do
    field :is_admin, :boolean, default: false
    belongs_to :user, MapleTree.Users.User
    belongs_to :group, MapleTree.Groups.Group

    timestamps()
  end

  @doc false
  def changeset(user_group, attrs) do
    user_group
    |> cast(attrs, [:is_admin])
    |> validate_required([:is_admin])
  end
end
