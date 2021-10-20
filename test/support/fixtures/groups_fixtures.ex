defmodule MapleTree.GroupsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MapleTree.Users` context.
  """

  def valid_group_name, do: "haken fanbase"
  def valid_group_description, do: "group..."

  def valid_group_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      name: valid_group_name(),
      description: valid_group_description(),
    })
  end

  def group_fixture(user_id, attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_group_attributes()
      |> MapleTree.Groups.create_group(user_id)

    user
  end

end
