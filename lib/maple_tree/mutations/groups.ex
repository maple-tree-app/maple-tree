defmodule MapleTree.Mutations.Groups do
  import Ecto.Query, warn: false
  alias MapleTree.Repo

  alias MapleTree.Schemas.Groups.{Group,UserGroup,Invite,ShoppingItem}

  def create_group_changeset(attrs \\ %{}), do: Group.changeset(%Group{}, attrs)

  def create_group(attrs, user_id) do
    Ecto.Multi.new()
    |> Ecto.Multi.insert(:group, Group.changeset(%Group{}, attrs))
    |> Ecto.Multi.insert(:users_groups, fn %{group: group} ->
      UserGroup.changeset(%UserGroup{}, %{
        group_id: group.id,
        user_id: user_id,
        is_admin: true
      })
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{group: group}} -> {:ok, group}
      {:error, :group, changeset, _} -> {:error, changeset}
    end
  end

  def generate_invite_code(group_id, user_id) do

    invite = Repo.insert!(Invite.insert_changeset(%Invite{}, %{
      "created_by" => user_id,
      "group_id" => group_id,
      "valid_until" => DateTime.add(DateTime.utc_now(), 7 * 24 * 60 * 60) # 7 days
    }))

    {:ok, invite}
  end

  def add_user(group_id, user_id), do: Repo.insert!(UserGroup.changeset(%UserGroup{}, %{"group_id" => group_id, "user_id" => user_id}))

  def delete_expired_invite_codes, do: Repo.delete_all(from invite in Invite, where: invite.valid_until <= ^DateTime.utc_now())

  def add_shopping_list_item(%ShoppingItem{} = item), do: Repo.insert(item)

end
