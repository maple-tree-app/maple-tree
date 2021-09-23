defmodule MapleTree.Repo.Migrations.CreateGroupInvites do
  use Ecto.Migration

  def change do
    create table(:group_invites, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :invite_code, :string
      add :valid_until, :date
      add :group_id, references(:groups, on_delete: :delete_all, type: :binary_id)
      add :created_by, references(:users, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create unique_index(:group_invites, [:invite_code])
    create index(:group_invites, [:group_id])
    create index(:group_invites, [:created_by])
  end
end
