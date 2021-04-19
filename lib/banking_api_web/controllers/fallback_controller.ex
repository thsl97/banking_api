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

  defp convert_changeset_errors_to_json(errors) do
    errors
    |> Enum.map(fn {key, {message, _opts}} -> {key, message} end)
    |> Map.new()
  end
end
