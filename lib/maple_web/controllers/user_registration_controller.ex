defmodule MapleWeb.UserRegistrationController do
  use MapleWeb, :controller

  def create(conn, %{"user" => user}) do
    IO.inspect user
    # form is already validated here, create the changeset and register user
    redirect(conn, to: "/")
  end
end
