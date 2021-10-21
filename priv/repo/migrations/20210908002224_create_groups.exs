defmodule MapleTree.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :color, :string
      add :description, :string
      add :image_url, :string

      timestamps()
    end
  end
end
