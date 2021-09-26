defmodule MapleTree.Repo.Migrations.CreateUsersFriendships do
  use Ecto.Migration

  def change do
    create table(:users_friendships, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :accepted, :boolean, default: false, null: false
      add :from_user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :to_user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:users_friendships, [:from_user_id, :to_user_id])
  end
end
