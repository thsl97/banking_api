defmodule BankingApiWeb.Router do
  use BankingApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BankingApiWeb do
    pipe_through :api

    post "/users/create", UserController, :create
    patch "/accounts/:id/withdraw", AccountController, :withdraw
    post "/accounts/:id/transfer", AccountController, :transfer
  end
end
