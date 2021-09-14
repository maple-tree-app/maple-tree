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

  def get_groups(user_id) do
    IO.inspect(user_id)
    IO.inspect("____________________")
    query = from(
      ug in UserGroup,
      where: ug.user_id == ^user_id,
      join: group in assoc(ug, :group),
      order_by: [desc: ug.is_admin],
      select: group)

    Repo.all(query) |> Repo.preload(:users)
  end
end
