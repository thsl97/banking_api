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

  @doc """
  Withdraws an amount from an account and adds it to another account
  """
  def transfer(source_account, destination_account, amount) do
    case BankAccount.changeset(source_account, %{balance: source_account.balance - amount}) do
      %{valid?: true} = source_changeset ->
        Ecto.Multi.new()
        |> Ecto.Multi.update(:source_acc, source_changeset)
        |> Ecto.Multi.update(:destination_acc, BankAccount.changeset(destination_account, %{balance: destination_account.balance + amount}))
        |> Repo.transaction()
        |> case do
          {:ok, %{destination_acc: destination_acc, source_acc: source_acc}} ->
            {:ok, source_acc, destination_acc}
          {:error, failed_operation, failed_value} ->
            {:error, failed_operation, failed_value}
          end
      %{valid?: false} = changeset ->
        {:error, changeset}
    end
  end
end
