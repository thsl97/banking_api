defmodule BankingApi.BankAccounts do
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
  alias BankingApi.Users

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "bank_accounts" do
    belongs_to :user, Users
    field :balance, :integer

    timestamps()
  end
end
