defmodule BankingApi.Users do
  @moduledoc """
  Domain public functions for the Users context
  """

  alias BankingApi.Schemas.{User, BankAccount}
  alias BankingApi.Repo

  @doc """
  Given a changeset, attempt to insert a new user in the database and create
  its bank account afterwards. Might fail due to unique email constraing
  """
  def create_user(attrs \\ %{}) do
    case User.changeset(%User{}, attrs) do
      %{valid?: true} = changeset ->
        changeset
        |> Ecto.Changeset.put_change(:account, %BankAccount{balance: 1000})
        |> Repo.insert()
      %{valid?: false} = changeset ->
        {:error, changeset}
    end
  rescue Ecto.ConstraintError ->
    {:error, :email_conflict}
  end
end
