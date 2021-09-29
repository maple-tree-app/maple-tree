defmodule MapleTreeWeb.JoinGroupLive do
  use MapleTreeWeb, :live_view

  alias Phoenix.View
  alias MapleTreeWeb.Helpers.LiveHelpers
  alias MapleTree.Groups

  @impl true
  def mount(%{"code" => invite_code}, session, socket) do
    {:ok, socket |> LiveHelpers.init(session) |> assign(group: Groups.get_group_by_invite_code(invite_code))}
  end

  @impl true
  def render(assigns) do
    View.render(MapleTreeWeb.GroupsView, "join.html", assigns)
  end

end
