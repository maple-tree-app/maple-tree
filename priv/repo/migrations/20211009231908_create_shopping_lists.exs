defmodule MapleTree.Repo.Migrations.CreateShoppingLists do
  use Ecto.Migration

  def change do
    create table(:shopping_lists, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :image_url, :string
      add :description, :string
      add :group_id, references(:groups, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:shopping_lists, [:group_id])
  end
end
