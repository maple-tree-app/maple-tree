defmodule Maple.Repo do
  use Ecto.Repo,
    otp_app: :maple,
    adapter: Ecto.Adapters.Postgres
end
