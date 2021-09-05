defmodule MapleTreeWeb.Helpers.LiveHelpers do
  import Phoenix.LiveView
  alias MapleTree.Users

  def pre_build(socket, session) do
    maybe_put_locale(session)
    maybe_assign_current_user(socket, session)
  end

  defp maybe_put_locale(session) do
    if locale = session["locale"] do
      Gettext.put_locale(MapleTreeWeb.Gettext, locale)
    end
  end

  defp maybe_assign_current_user(socket, session) do
    if token = Map.get(session, "user_token") do
      assign_current_user(socket, token)
    end
  end
  defp assign_current_user(socket, user_token) do
    assign_new(socket, :current_user, fn -> Users.get_user_by_session_token(user_token) end)
  end
end
