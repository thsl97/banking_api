defmodule BankingApi.Schemas.BankAccount do
  @moduledoc """
  The entity of Bank Accounts. Establishes a one to one relationship to Users
  schema and uses User's id as primary key.

  ## Fields

    - user: the id of the user that owns the account. An user can have only
    one account
    - balance: the total balance of the account. Every account is created
    with 100000 (R$ 1000,00) as starting balance, and accounts cannot
    have negative balance
  """

  use Ecto.Schema
  alias BankingApi.Schemas.User
  import Ecto.Changeset

  @derive {Jason.Encoder, except: [:__meta__, :user]}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "bank_accounts" do
    belongs_to :user, User
    field :balance, :integer

    timestamps()
  end

  def changeset(account, params) do
    account
    |> cast(params, [:balance])
    |> validate_number(:balance, greater_than_or_equal_to: 0, message: "Not enough balance")
  end
end
