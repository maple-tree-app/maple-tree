defmodule MapleWeb.UserRegistrationLive do
  use MapleWeb, :live_view

  alias Phoenix.View
  alias Maple.Users
  alias Maple.Users.User

  def mount(_params, _session, socket) do
    {:ok, socket |> add_changeset}
  end

  def render(assigns) do
    View.render(MapleWeb.UserRegistrationView, "new.html", assigns)
  end

  defp add_changeset(socket) do
    params = [changeset: Users.change_user_registration(%User{}), trigger_submit: false]
    assign(socket, params)
  end

end
