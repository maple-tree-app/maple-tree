defmodule MapleTree.Schemas.Users.UserSettings do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users_settings" do
    field :theme, :string
    field :locale, :string
    belongs_to :user, MapleTree.Schemas.Users.User, type: :binary_id

    timestamps()
  end


  def registration_changeset(attrs), do: apply_changeset(%MapleTree.Schemas.Users.UserSettings{}, attrs)



  defp apply_changeset(%MapleTree.Schemas.Users.UserSettings{} = user_settings, attrs) do
    user_settings |> cast(attrs, [:theme, :locale, :user_id]) |> foreign_key_constraint(:user_id)
  end

end
