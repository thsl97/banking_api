defmodule BankingApi.Users do
  @moduledoc """
  The entity of User. An User can have only one bank account

  ## Fields

    - name: The user's name
    - email: The user's email. Must be unique for each user
    - account: The user's bank account, if it exists. Evcery user can have
    only one bank account at a time
  """

  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "users" do
    field :name, :string
    field :email, :string
    has_one :account, {"user", BankingApi.BankAccounts}

    timestamps()
  end
end
