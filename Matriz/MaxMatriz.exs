defmodule MaxMatriz do
  def main do
    matriz = [
      [1, 2, 3],
      [4, 50, 6],
      [7, 8, 9]
    ]

    max = max_matriz(matriz)
    IO.puts("Máximo: #{max}")
  end

  # Tomamos la primera fila para iniciar
  def max_matriz([fila | resto]) do
    max_fila = max_lista(fila)
    max_general(resto, max_fila)
  end

  # Recorre las demás filas
  defp max_general([], max), do: max

  defp max_general([fila | resto], max) do
    nuevo_max = mayor(max, max_lista(fila))
    max_general(resto, nuevo_max)
  end

  # Máximo de una lista
  defp max_lista([x]), do: x

  defp max_lista([x | xs]) do
    mayor(x, max_lista(xs))
  end

  # Función para comparar dos números
  defp mayor(a, b) when a >= b, do: a
  defp mayor(_, b), do: b
end

MaxMatriz.main()
