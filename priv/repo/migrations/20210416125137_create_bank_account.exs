defmodule BankingApi.Repo.Migrations.CreateBankAccount do
  use Ecto.Migration

  def change do
    create table(:bank_accounts, primary_key: false) do
      add :user_id, :uuid, [references(:users), primary_key: true]
      add :balance, :integer

      timestamps()
    end
  end
end
