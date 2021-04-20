defmodule BankingApiWeb.FallbackController do
  use Phoenix.Controller

  def call(conn, {:error, %Ecto.Changeset{errors: errors}}) do
    conn
    |> put_status(:bad_request)
    |> json(%{
      type: "bad_request",
      description: "Invalid Input",
      details: convert_changeset_errors_to_json(errors)
    })
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> json(%{
      type: "not_found",
      description: "The requested resource was not found on this server"
    })
  end

  defp convert_changeset_errors_to_json(errors) do
    errors
    |> Enum.map(fn {key, {message, _opts}} -> {key, message} end)
    |> Map.new()
  end
end
