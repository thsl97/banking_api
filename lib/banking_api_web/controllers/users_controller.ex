defmodule BankingApiWeb.UserController do
  @moduledoc """
  Actions related to the User resource
  """

  use BankingApiWeb, :controller

  alias BankingApi.Schemas.User
  alias BankingApi.Users

  def create(conn, params) do
    with {:ok, %User{} = user} <- Users.create_user(params) do
      json(conn, user)
    end
  end
end
