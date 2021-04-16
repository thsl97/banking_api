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
      {:error, %Ecto.Changeset{errors: errors}} ->
        conn
        |> put_status(:bad_request)
        |> json(%{
          type: "bad_request",
          description: "Invalid Input",
          details: convert_changeset_errors_to_json(errors)
        })
        {:error, :email_conflict} ->
          conn
          |> put_status(:conflict)
          |> json(%{
            type: "conflict",
            description: "Email already taken",
          })
    end
  end

  defp convert_changeset_errors_to_json(errors) do
    errors
    |> Enum.map(fn {key, {message, _opts}} -> {key, message} end)
    |> Map.new()
  end
end
