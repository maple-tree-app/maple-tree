defmodule MapleTree.Groups do
  import Ecto.Query, warn: false
  alias MapleTree.Repo

  alias MapleTree.Groups.Group
  alias MapleTree.Groups.UserGroup

  def create_group_changeset(attrs \\ %{}), do: Group.changeset(%Group{}, attrs)

  def create_group(attrs, user_id) do
    Ecto.Multi.new()
      |> Ecto.Multi.insert(:group, Group.changeset(%Group{}, attrs))
      |> Ecto.Multi.insert(:users_groups, fn %{group: group} ->
        IO.inspect(group)
        UserGroup.changeset(%UserGroup{}, %{
        group_id: group.id,
        user_id: user_id,
        is_admin: true
      }) end)
      |> Repo.transaction()
      |> case do
        {:ok, %{group: group}} -> {:ok, group}
        {:error, :group, changeset, _} -> {:error, changeset}
      end
  end
end
