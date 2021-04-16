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
    %User{}
    |> User.changeset(attrs)
    |> Ecto.Changeset.put_change(:account, %BankAccount{balance: 1000})
    |> Repo.insert()
  end
end
