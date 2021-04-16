defmodule BankingApi.Schemas.User do
  @moduledoc """
  The entity of User. An User can have only one bank account

  ## Fields

    - name: The user's name
    - email: The user's email. Must be unique for each user
    - account: The user's bank account, if it exists. Evcery user can have
    only one bank account at a time
  """

  use Ecto.Schema
  alias BankingApi.Schemas.BankAccount
  import Ecto.Changeset

  @required [:name, :email]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :name, :string
    field :email, :string
    has_one :account, {"user", BankAccount}

    timestamps()
  end

  def changeset(user, params) do
    user
    |> cast(params, @required)
    |> validate_required(@required)
    |> validate_length(:name, min: 3)
    |> validate_format(:email, ~r/^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/)
  end
end
