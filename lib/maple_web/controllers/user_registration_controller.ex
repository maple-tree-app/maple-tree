defmodule MapleWeb.UserRegistrationController do
  use MapleWeb, :controller

  def create(conn, %{"user" => user}) do
    IO.inspect(user)
    redirect(conn, to: "/")
  end
end
