defmodule MapleWeb.UserRegistrationLive do
  use MapleWeb, :live_view

  alias Phoenix.View
  alias Maple.Users

  def mount(_params, _session, socket) do
    {:ok, socket |> add_changeset}
  end

  def render(assigns) do
    View.render(MapleWeb.UserRegistrationView, "new.html", assigns)
  end

  defp add_changeset(socket) do
    params = [changeset: Users.change_user_registration(), trigger_submit: false, button_disabled: true]
    assign(socket, params)
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    changeset = apply_changeset(user_params)
    {:noreply, assign(socket, changeset: changeset, trigger_submit: changeset.valid?)}
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    IO.inspect apply_changeset(user_params)
    {:noreply, assign(socket, changeset: apply_changeset(user_params))}
  end

  defp apply_changeset(user_params), do: Users.change_user_registration(user_params)

end
