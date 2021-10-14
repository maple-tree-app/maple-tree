defmodule MapleTree.Groups do
  import Ecto.Query, warn: false
  alias MapleTree.Repo

  alias MapleTree.Groups.{Group, UserGroup, Invite, ShoppingList}

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


  def get_invite_code_valid_for_7_days(group_id, user_id) do
    case Repo.one(first(from invite in Invite, where: invite.created_by == ^user_id and invite.group_id == ^group_id and invite.valid_until >= ^(DateTime.utc_now() |> DateTime.add(6 * 24 * 60 * 60)))) do
      nil -> generate_invite_code(group_id, user_id)
      invite -> {:ok, invite}
    end
  end

  def generate_invite_code(group_id, user_id) do
    invite = Invite.insert_changeset(%Invite{}, %{
      "created_by" => user_id,
      "group_id" => group_id,
      "valid_until" => DateTime.utc_now() |> DateTime.add(7 * 24 * 60 * 60) # 7 days 
    }) |> Repo.insert!()

    {:ok, invite}
  end

  def get_group_by_invite_code(invite_code) do
    Repo.one(
      first(
        from invite in Invite,
        join: group in assoc(invite, :group),
        join: ug in subquery(from u in UserGroup, 
          group_by: u.group_id,
          select: %{group_id: u.group_id, members_count: count(u.id)}),
        on: ug.group_id == group.id,
        where: invite.invite_code == ^invite_code,
        select: group,
        select_merge: %{members_count: ug.members_count}
      )
    )
  end

  def add_user(group_id, user_id), do: Repo.insert! UserGroup.changeset(%UserGroup{}, %{"group_id" => group_id, "user_id" => user_id})

  # TODO: add test for this
  def delete_expired_invite_codes do
    Repo.delete_all(from invite in Invite, where: invite.valid_until <= ^DateTime.utc_now())
  end

  def create_shopping_list(attrs) do
    Repo.insert!(ShoppingList.changeset(%ShoppingList{}, attrs))
  end

  defp add_params(query, params) do
    Enum.reduce(params, query, fn
      {"name", name}, query -> where(query, [groups: g], ilike(g.name, ^"%#{name}%"))
      {"admin_only", "true"}, query -> where(query, [ug: ug], ug.is_admin == true)
      _, query -> query
    end)
  end

end
