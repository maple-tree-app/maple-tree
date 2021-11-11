defmodule MapleTree.GroupsTest do
  use MapleTree.DataCase, async: true

  alias MapleTree.Groups
  import MapleTree.UsersFixtures
  import MapleTree.GroupsFixtures
  alias MapleTree.Schemas.Groups.Invite

 setup do
    user = user_fixture()
    %{user: user, group: group_fixture(user.id)}
  end

  describe "delete_expired_invite_codes/0" do
    test "deletes expired invite codes", %{group: group, user: user} do
      invite = Repo.insert!(Invite.insert_changeset(%Invite{}, %{
        "created_by" => user.id,
        "group_id" => group.id,
        "valid_until" => DateTime.add(DateTime.utc_now(), -7 * 24 * 60 * 60) # 7 days
      }))
      
      Groups.delete_expired_invite_codes
      
      assert Repo.get(Invite, invite.id) == nil
 
    end
    test "does not delete valid invite codes", %{group: group, user: user} do
      invite = Repo.insert!(Invite.insert_changeset(%Invite{}, %{
        "created_by" => user.id,
        "group_id" => group.id,
        "valid_until" => DateTime.add(DateTime.utc_now(), 7 * 24 * 60 * 60) # 7 days
      }))

      Groups.delete_expired_invite_codes
      
      assert %Invite{} = Repo.get(Invite, invite.id)
    end 
  end
end
