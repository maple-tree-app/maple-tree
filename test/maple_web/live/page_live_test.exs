defmodule MapleTreeWeb.PageLiveTest do
  use MapleTreeWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert is_binary(render(page_live))
  end
end
