defmodule Maple.Repo.Migrations.CreateUsersGroups do
  use Ecto.Migration

  def change do
    create table(:users_groups, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :is_admin, :boolean, default: false, null: false
      add :is_favorite, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :group_id, references(:groups, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:users_groups, [:user_id])
    create index(:users_groups, [:group_id])
  end
end
