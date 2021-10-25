defmodule MapleTree.Access.Groups do
  import Ecto.Query, warn: false
  alias MapleTree.Repo

  alias MapleTree.Schemas.Groups.{Group, UserGroup, Invite, ShoppingList, ShoppingItem}
  
  def get_groups(user_id, search_params \\ []) do
    query =
      from(UserGroup, as: :ug)
      |> join(:left, [ug: user_group], assoc(user_group, :group), as: :groups)
      |> where([ug, g], ug.user_id == ^user_id)
      |> order_by([user_group, g], desc: user_group.is_admin)
      |> select([groups: g], g)
      |> add_group_search_params(search_params)

    Repo.all(query)
  end

  def get_group(group_id, _search_params \\ []) do
    query =
      from(Group, as: :group)
      |> where([group: group], group.id == ^group_id)
      |> preload(users_groups: :user)

    Repo.one(query)
  end

  def user_belongs_to_group?(group_id, user_id) do
    Repo.exists?(from ug in UserGroup, where: ug.user_id == ^user_id and ug.group_id == ^group_id)
  end

  def get_invite_code_valid_for_7_days(group_id, user_id) do
    case Repo.one(
           first(
             from invite in Invite,
               where:
                 invite.created_by == ^user_id and invite.group_id == ^group_id and
                   invite.valid_until >= ^(DateTime.utc_now() |> DateTime.add(6 * 24 * 60 * 60))
           )
         ) do
      nil -> MapleTree.Groups.generate_invite_code(group_id, user_id)
      invite -> {:ok, invite}
    end
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

  def get_group_shopping_lists(group_id, search_params \\ []) do
    query =
      from(ShoppingList, as: :sl)
        |> where([sl: sl], sl.group_id == ^group_id)
        |> add_group_search_params(search_params)
    Repo.all(query)
  end

  def add_shopping_list_search_params(query, params) do
    Enum.reduce(params, query, fn
      {"limit", limit}, query -> limit(query, ^limit)
      {"count_items", true}, query -> 
        join_query = join(query, :left,
          [sl: sl],
          subquery(
            from i in ShoppingItem,
            group_by: i.shopping_list_id,
            select: %{shopping_list_id: i.shopping_list_id, items_count: count(i.id)}
          ), as: :items)
        select_merge(join_query, [items: items], %{items_count: items.items_count})
      _, query -> query
    end)
  end

  defp add_group_search_params(query, params) do
    Enum.reduce(params, query, fn
      {"name", name}, query -> where(query, [groups: g], ilike(g.name, ^"%#{name}%"))
      {"admin_only", "true"}, query -> where(query, [ug: ug], ug.is_admin == true)
      _, query -> query
    end)
  end
end
