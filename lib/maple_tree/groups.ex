defmodule MapleTree.Groups do
  import Ecto.Query, warn: false
  alias MapleTree.Repo

  alias MapleTree.Schemas.Groups.ShoppingList

  # mutations
  defdelegate create_group_changeset(attrs \\ %{}), to: MapleTree.Mutations.Groups
  defdelegate create_group(attrs, user_id), to: MapleTree.Mutations.Groups
  defdelegate generate_invite_code(group_id, user_id), to: MapleTree.Mutations.Groups
  defdelegate add_user(group_id, user_id), to: MapleTree.Mutations.Groups

  # access
  defdelegate get_groups(user_id, search_params \\ []) , to: MapleTree.Access.Groups
  defdelegate get_group_by_invite_code(invite_code), to: MapleTree.Access.Groups
  defdelegate get_group(group_id, search_params \\ []), to: MapleTree.Access.Groups
  defdelegate user_belongs_to_group?(group_id, user_id), to: MapleTree.Access.Groups
  defdelegate get_invite_code_valid_for_7_days(group_id, user_id), to: MapleTree.Access.Groups
  defdelegate get_group_shopping_lists(group_id, search_params \\ []), to: MapleTree.Access.Groups

  def create_shopping_list(attrs) do
    Repo.insert(ShoppingList.changeset(%ShoppingList{}, attrs))
  end

end
