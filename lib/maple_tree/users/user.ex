defmodule MapleTree.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias MapleTree.Repo

  @derive {Inspect, except: [:password]}
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :username, :string
    field :password, :string, virtual: true
    field :name, :string
    field :image_url, :string
    field :hashed_password, :string
    field :confirmed_at, :naive_datetime
    field :friendships, :any, virtual: true

    timestamps()

    has_one :settings, MapleTree.Users.UserSettings
    has_many :users_groups, MapleTree.Groups.UserGroup, on_delete: :delete_all
    many_to_many :groups, MapleTree.Groups.Group, join_through: MapleTree.Groups.UserGroup

    has_many :friendship_pivot, MapleTree.Users.Friendship, foreign_key: :from_user_id
    has_many :reverse_friendship_pivot, MapleTree.Users.Friendship, foreign_key: :to_user_id

    many_to_many :friends, MapleTree.Users.User,
      join_through: "users_friendships",
      join_where: [accepted: true],
      preload_order: [desc: :username],
      join_keys: [from_user_id: :id, to_user_id: :id]

    many_to_many :reverse_friends, MapleTree.Users.User,
      join_through: "users_friendships",
      join_where: [accepted: true],
      preload_order: [desc: :username],
      join_keys: [to_user_id: :id, from_user_id: :id]

    many_to_many :pending_friend_invites, MapleTree.Users.User,
      join_through: "users_friendships",
      join_where: [accepted: false],
      preload_order: [desc: :inserted_at],
      join_keys: [to_user_id: :id, from_user_id: :id]

    many_to_many :requested_friends, MapleTree.Users.User,
      join_through: "users_friendships",
      join_where: [accepted: false],
      preload_order: [asc: :inserted_at],
      join_keys: [from_user_id: :id, to_user_id: :id]

  end

  @doc """
  A user changeset for registration.

  It is important to validate the length of both email and password.
  Otherwise databases may truncate the email without warnings, which
  could lead to unpredictable or insecure behaviour. Long passwords may
  also be very expensive to hash for certain algorithms.

  ## Options

    * `:hash_password` - Hashes the password so it can be stored securely
      in the database and ensures the password field is cleared to prevent
      leaks in the logs. If password hashing is not needed and clearing the
      password field is not desired (like when using this changeset for
      validations on a LiveView form), this option can be set to `false`.
      Defaults to `true`.
  """
  def registration_changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:email, :password, :name, :username])
    |> validate_required([:email, :password, :username])
    |> validate_email(opts)
    |> validate_password(opts)
  end

  defp validate_email(changeset, opts \\ []) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 60)
    |> maybe_unsafe_validate_unique_email(opts)
    |> unique_constraint(:email)
  end

  defp validate_password(changeset, opts) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 12, max: 80)
    # |> validate_format(:password, ~r/[a-z]/, message: "at least one lower case character")
    # |> validate_format(:password, ~r/[A-Z]/, message: "at least one upper case character")
    # |> validate_format(:password, ~r/[!?@#$%^&*_0-9]/, message: "at least one digit or punctuation character")
    |> maybe_hash_password(opts)
  end

  defp maybe_hash_password(changeset, opts) do
    hash_password? = Keyword.get(opts, :hash_password, true)
    password = get_change(changeset, :password)

    if hash_password? && password && changeset.valid? do
      changeset
      |> put_change(:hashed_password, Bcrypt.hash_pwd_salt(password))
      |> delete_change(:password)
    else
      changeset
    end
  end

  defp maybe_unsafe_validate_unique_email(changeset, opts) do
    case Keyword.get(opts, :validate_unique_email, false) do
      true -> unsafe_validate_unique(changeset, :email, MapleTree.Repo)
      false -> changeset
    end
  end

  @doc """
  A user changeset for changing the email.

  It requires the email to change otherwise an error is added.
  """
  def email_changeset(user, attrs) do
    user
    |> cast(attrs, [:email])
    |> validate_email()
    |> case do
      %{changes: %{email: _}} = changeset -> changeset
      %{} = changeset -> add_error(changeset, :email, "did not change")
    end
  end

  @doc """
  A user changeset for changing the password.

  ## Options

    * `:hash_password` - Hashes the password so it can be stored securely
      in the database and ensures the password field is cleared to prevent
      leaks in the logs. If password hashing is not needed and clearing the
      password field is not desired (like when using this changeset for
      validations on a LiveView form), this option can be set to `false`.
      Defaults to `true`.
  """
  def password_changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:password])
    |> validate_confirmation(:password, message: "does not match password")
    |> validate_password(opts)
  end

  @doc """
  Confirms the account by setting `confirmed_at`.
  """
  def confirm_changeset(user) do
    now = NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
    change(user, confirmed_at: now)
  end

  @doc """
  Verifies the password.

  If there is no user or the user doesn't have a password, we call
  `Bcrypt.no_user_verify/0` to avoid timing attacks.
  """
  def valid_password?(%MapleTree.Users.User{hashed_password: hashed_password}, password)
      when is_binary(hashed_password) and byte_size(password) > 0 do
    Bcrypt.verify_pass(password, hashed_password)
  end

  def valid_password?(_, _) do
    Bcrypt.no_user_verify()
    false
  end

  @doc """
  Validates the current password otherwise adds an error to the changeset.
  """
  def validate_current_password(changeset, password) do
    if valid_password?(changeset.data, password) do
      changeset
    else
      add_error(changeset, :current_password, "is not valid")
    end
  end

  def preload_friends(%MapleTree.Users.User{} = user) do
    user = Repo.preload(user, [:friends, :reverse_friends, :requested_friends, :pending_friend_invites])
    Map.put(user, :friendships, Enum.sort_by(user.friends ++ user.reverse_friends, &(&1.username)))
  end

end
