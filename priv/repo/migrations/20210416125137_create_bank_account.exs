defmodule BankingApi.Repo.Migrations.CreateBankAccount do
  use Ecto.Migration

  def change do
    create table(:bank_accounts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :user_id, references(:users, type: :uuid)
      add :balance, :integer

      timestamps()
    end

    create unique_index(:bank_accounts, [:user_id])
  end
end
