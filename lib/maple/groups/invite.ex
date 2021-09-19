defmodule MapleTree.Groups.Invite do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "group_invites" do
    field :invite_code, :string
    field :valid_until, :date
    field :group_id, :binary_id
    field :created_by, :binary_id

    timestamps()
  end

  @doc false
  def changeset(invite, attrs) do
    invite
    |> cast(attrs, [:invite_code, :valid_until])
    |> validate_required([:invite_code, :valid_until])
  end
end
