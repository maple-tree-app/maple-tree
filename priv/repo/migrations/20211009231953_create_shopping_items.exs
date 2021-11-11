defmodule MapleTree.Repo.Migrations.CreateShoppingItems do
  use Ecto.Migration

  def change do
    create table(:shopping_items, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :quantity, :integer
      add :detail, :string

      add :shopping_list_id, references(:shopping_lists, on_delete: :delete_all, type: :binary_id)
      add :group_id, references(:groups, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:shopping_items, [:shopping_list_id])
  end
end
