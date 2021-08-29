defmodule MapleWeb.UserRegistrationController do
  use MapleWeb, :controller

  def create(conn, %{"user" => user}) do
    redirect(conn, to: "/")
  end
end
