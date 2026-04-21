defmodule DiagonalSecundaria do
  def main do
    matriz = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]

    suma = diagonal_secundaria(matriz)
    IO.puts("Suma diagonal secundaria: #{suma}")
  end

  def diagonal_secundaria(matriz) do
    n = length(matriz)
    recorrer(matriz, 0, n)
  end

  # Caso base
  defp recorrer([], _, _), do: 0

  # Caso recursivo
  defp recorrer([fila | resto], fila_idx, n) do
    col = n - fila_idx - 1
    Enum.at(fila, col) + recorrer(resto, fila_idx + 1, n)
  end
end

DiagonalSecundaria.main()
