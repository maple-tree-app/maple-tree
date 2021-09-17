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

  def get_groups(user_id, search_params \\ []) do
    query = from(UserGroup, as:  :ug)
      |> join(:left, [ug: user_group], g in assoc(user_group, :group), as: :groups)
      |> where([ug, g], ug.user_id == ^user_id)
      |> order_by([user_group, g], [desc: user_group.is_admin])
      |> select([groups: g], g)
      |> add_params(search_params)
    Repo.all(query)
  end

  def get_group(group_id, _search_params \\ []) do
    query = from(Group, as: :group)
      |> where([group: group], group.id == ^group_id)
      |> preload([users_groups: :user])

    Repo.one(query)
  end

  def user_belongs_to_group?(group_id, user_id) do
    Repo.exists? from ug in UserGroup, where: ug.user_id == ^user_id and ug.group_id == ^group_id
  end

  defp add_params(query, params) do
    Enum.reduce(params, query, fn
      {"name", name}, query -> where(query, [groups: g], like(g.name, ^"%#{name}%"))
      {"admin_only", "true"}, query -> where(query, [ug: ug], ug.is_admin == true)
      _, query -> query
    end)
  end
end
