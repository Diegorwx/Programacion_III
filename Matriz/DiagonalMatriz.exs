defmodule DiagonalMatriz do
  def main do
    matriz = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]

    imprimir_diagonal(matriz)
  end

  def imprimir_diagonal(matriz) do
    recorrer(matriz, 0)
  end

  defp recorrer([], _), do: :ok

  defp recorrer([fila | resto], col) do
    IO.puts(Enum.at(fila, col))
    recorrer(resto, col + 1)
  end
end

DiagonalMatriz.main()
