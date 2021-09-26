defmodule MapleTree.Users.Friendship do
  use Ecto.Schema
  import Ecto.Changeset
  alias MapleTree.Users.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users_friendships" do
    field :accepted, :boolean, default: false

    belongs_to :from_user, User
    belongs_to :to_user, User

    timestamps()
  end

  @doc false
  def changeset(friendship, attrs) do
    friendship
    |> cast(attrs, [:accepted])
    |> validate_required([:accepted])
  end
end
