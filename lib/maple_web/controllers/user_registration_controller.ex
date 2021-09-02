defmodule MapleWeb.UserRegistrationController do
  use MapleWeb, :controller
  alias Maple.Users.User
  alias Maple.Users
  alias MapleWeb.UserAuth



  def create(conn, %{"user" => user}) do
    IO.inspect(user)
    case Users.register_user(user) do
      {:ok, user} ->

        # creates confirmation token and creates email
        # TODO create email service to deliver this
        {:ok, _} = Users.deliver_user_confirmation_instructions(user, &Routes.user_confirmation_url(conn, :confirm, &1))

        conn |> put_flash(:info, "User created successfully.") |> UserAuth.log_in_user(user)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
          |> put_view(MapleWeb.UserRegistrationView)
          |> render("new.html", changeset: changeset)
    end
    redirect(conn, to: "/")
  end
end
