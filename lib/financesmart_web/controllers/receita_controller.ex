defmodule FinancesmartWeb.ReceitaController do
  use FinancesmartWeb, :controller
  import Ecto.Query

  alias Financesmart.Finance
  alias Financesmart.Finance.Receita
  alias Financesmart.Repo

  def index(conn, _params) do
    receitas = Finance.list_receitas()
    render(conn, :index, receitas: receitas)
  end

  def filtrar(conn, %{"tipo" => tipo, "valor" => valor, "mes" => mes, "ano" => ano, "data_inicio" => data_inicio, "data_fim" => data_fim}) do
    query =
      Receita
      |> filtrar_por_tipo(tipo)
      |> filtrar_por_valor(valor)
      |> filtrar_por_mes(mes, ano)
      |> filtrar_por_periodo(data_inicio, data_fim)

    receitas = Repo.all(query)
    render(conn, "index.html", receitas: receitas)
  end

  defp filtrar_por_tipo(query, nil), do: query
  defp filtrar_por_tipo(query, tipo), do: from(r in query, where: r.tipo == ^tipo)

  defp filtrar_por_valor(query, nil), do: query
  defp filtrar_por_valor(query, valor), do: from(r in query, where: r.valor >= ^valor)

  defp filtrar_por_mes(query, nil, _), do: query
defp filtrar_por_mes(query, _mes, nil), do: query
defp filtrar_por_mes(query, mes, ano) do
  from(r in query,
    where:
      fragment("EXTRACT(MONTH FROM ?) = ?", r.data, ^mes) and
      fragment("EXTRACT(YEAR FROM ?) = ?", r.data, ^ano)
  )
end

  defp filtrar_por_periodo(query, nil, nil), do: query
  defp filtrar_por_periodo(query, nil, _data_fim), do: query
  defp filtrar_por_periodo(query, _data_inicio, nil), do: query
  defp filtrar_por_periodo(query, data_inicio, data_fim) do
    from(r in query, where: r.data >= ^data_inicio and r.data <= ^data_fim)
  end
end
