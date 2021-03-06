defmodule MapleTreeWeb.UserRegistrationLive do
  use MapleTreeWeb, :live_view

  alias Phoenix.View
  alias MapleTree.Users
  alias MapleTreeWeb.Helpers.LiveHelpers

  def mount(_params, session, socket) do
    {:ok, socket |> LiveHelpers.init(session) |> add_changeset}
  end

  def render(assigns) do
    View.render(MapleTreeWeb.UserRegistrationView, "new.html", assigns)
  end

  defp add_changeset(socket) do
    params = [
      changeset: Users.change_user_registration(),
      trigger_submit: false,
      button_disabled: true
    ]

    assign(socket, params)
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    changeset = Map.put(apply_changeset(user_params, hash_password: true, validate_unique_email: true), :action, :update)
    {:noreply, assign(socket, changeset: changeset, trigger_submit: changeset.valid?)}
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    {:noreply, assign(socket, changeset: apply_changeset(user_params))}
  end

  defp apply_changeset(user_params, opts \\ []),
    do: Users.change_user_registration(user_params, opts)
end
