defmodule BankingApi.BankAccounts do
  @moduledoc """
  Domain public functions for the Bank Accounts context
  """

  alias BankingApi.Repo
  alias BankingApi.Schemas.BankAccount

  @doc """
  Fetch a bank account from the database
  """
  def fetch(account_id) do
    case Repo.get(BankAccount, account_id) do
      nil -> {:error, :not_found}
      bank_account -> {:ok, bank_account}
    end
  rescue
    Ecto.Query.CastError -> {:error, :uuid}
  end

  @doc """
  Withdraws a specific amount from a given bank account. The remaining balance
  in the account cannot be negative.
  """
  def withdraw(bank_account, amount) do
    case BankAccount.changeset(bank_account, %{balance: bank_account.balance - amount}) do
      %{valid?: true} = changeset ->
        Repo.update(changeset)
      %{valid?: false} = changeset ->
        {:error, changeset}
    end
  rescue
    ArithmeticError -> {:error, :invalid_amount}
  end
end
