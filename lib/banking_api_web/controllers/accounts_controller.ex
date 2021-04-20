defmodule BankingApiWeb.AccountController do
  @moduledoc """
  Actions related to the Bank Account Resource
  """

  use BankingApiWeb, :controller
  alias BankingApi.Schemas.BankAccount
  alias BankingApi.BankAccounts

  # action_fallback BankingApiWeb.FallbackController

  @doc """
  Receives an account id and an amount to withdraw. Amount must be a positive integer.
  """
  def withdraw(conn, %{"id" => account_id, "amount" => amount}) do
    with {:ok, %BankAccount{} = bank_account} <- BankAccounts.fetch(account_id),
      {:ok, bank_account} <- BankAccounts.withdraw(bank_account, amount) do
        conn
        |> put_status(:no_content)
        |> json(bank_account)
    else
      {:error, :not_found} ->
        conn
        |> put_status(:not_found)
        |> json(%{
          type: "not_found",
          description: "Bank Account not found"
        })
      {:error, :uuid} ->
        conn
        |> put_status(:bad_request)
        |> json(%{
          type: "bad_request",
          description: "Invalid UUID format"
        })
      {:error, :invalid_amount} ->
        conn
        |> put_status(:bad_request)
        |> json(%{
          type: "bad_request",
          description: "Invalid Input",
          details: "Amount must be an integer"
        })
    end
  end

  def transfer(conn, %{"id" => account_id, "destination_id" => destination_account_id, "amount" => amount}) do
    with {:ok, %BankAccount{} = bank_account} <- BankAccounts.fetch(account_id),
      {:ok, %BankAccount{} = destination_account} <- BankAccounts.fetch(destination_account_id),
      {:ok, source_acc, destination_acc} <- BankAccounts.transfer(bank_account, destination_account, amount) do
        conn
        |> json(%{
          source_account: source_acc,
          destination_account: destination_acc
        })
      end
  end
end
