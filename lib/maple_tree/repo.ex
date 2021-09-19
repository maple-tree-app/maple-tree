defmodule MapleTree.Repo do
  use Ecto.Repo,
    otp_app: :maple_tree,
    adapter: Ecto.Adapters.Postgres
end
