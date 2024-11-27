defmodule Financesmart.FinanceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Financesmart.Finance` context.
  """

  @doc """
  Generate a receita.
  """
  def receita_fixture(attrs \\ %{}) do
    {:ok, receita} =
      attrs
      |> Enum.into(%{
        categoria: "some categoria",
        data: ~D[2024-11-26],
        descricao: "some descricao",
        valor: "120.5"
      })
      |> Financesmart.Finance.create_receita()

    receita
  end

  @doc """
  Generate a despesa.
  """
  def despesa_fixture(attrs \\ %{}) do
    {:ok, despesa} =
      attrs
      |> Enum.into(%{
        categoria: "some categoria",
        data: ~D[2024-11-26],
        descricao: "some descricao",
        valor: "120.5"
      })
      |> Financesmart.Finance.create_despesa()

    despesa
  end
end
