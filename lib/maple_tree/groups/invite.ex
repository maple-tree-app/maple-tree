defmodule MapleTree.Groups.Invite do
  use Ecto.Schema
  import Ecto.Changeset
  alias MapleTree.Util.Crypto

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
  def insert_changeset(invite, attrs) do
    invite
    |> cast(attrs, [:valid_until, :group_id, :created_by])
    |> validate_required([:valid_until, :group_id, :created_by])
    |> foreign_key_constraint(:group_id)
    |> foreign_key_constraint(:created_by)
    |> generate_unique_invite_code()
  end

  defp generate_unique_invite_code(changeset) do
    if changeset.valid? do
      case put_change(changeset, :invite_code, Crypto.random_string(8))
        |> unsafe_validate_unique(:invite_code, MapleTree.Repo) do
        %{valid?: false} = _ -> generate_unique_invite_code(changeset)
        changeset_with_unique_code -> changeset_with_unique_code
      end
    else
      changeset
    end
  end
end
