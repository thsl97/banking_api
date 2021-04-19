defmodule BankingApiWeb.UserController do
  @moduledoc """
  Actions related to the User resource
  """

  use BankingApiWeb, :controller

  alias BankingApi.Schemas.User
  alias BankingApi.Users

  def create(conn, params) do
    with {:ok, %User{} = user} <- Users.create_user(params) do
      conn
      |> put_status(:created)
      |> json(user)
    else
      {:error, :email_conflict} ->
        conn
        |> put_status(:conflict)
        |> json(%{
          type: "conflict",
          description: "Email already taken",
        })
    end
  end
end
