defmodule SumaMatriz do
  def main do
    matriz = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]

    resultado = suma_matriz(matriz)
    IO.puts("Suma total: #{resultado}")
  end

  # Recorre la matriz (fila por fila)
  def suma_matriz([]), do: 0

  def suma_matriz([fila | resto]) do
    suma_fila(fila) + suma_matriz(resto)
  end

  # Recorre una fila (elemento por elemento)
  defp suma_fila([]), do: 0

  defp suma_fila([x | xs]) do
    x + suma_fila(xs)
  end
end

SumaMatriz.main()
