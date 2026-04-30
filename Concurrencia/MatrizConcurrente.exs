defmodule Matriz do
  def main do
    matriz = [
      [60, 22, 41, 5],
      [13, 33, 44, 5],
      [89, 10, 100, 99],
      [5, 101, 6, 34]
    ]

    a = Task.async(fn -> suma_bajo_diagonal(matriz) end)
    b = Task.async(fn -> promedio_numeros(matriz) end)

  # 3. Multiplicar los resultados de las tareas anteriores
    c = Task.await(a) * Task.await(b)

  # 4. Imprimir el resultado de la multiplicación
    IO.puts("El valor de C es: #{c}")
  end

  # 1. Suma de los números bajo la diagonal principal

  def suma_bajo_diagonal(matriz) do
    recorrer_filas(matriz, 0)
  end

  defp recorrer_filas([], _), do: 0

  defp recorrer_filas([fila | resto], fila_idx) do
    suma_fila(fila, 0, fila_idx) + recorrer_filas(resto, fila_idx + 1)
  end

  defp suma_fila([], _, _), do: 0

  defp suma_fila([x | xs], col_idx, fila_idx) do
    if col_idx < fila_idx do
      x + suma_fila(xs, col_idx + 1, fila_idx)
    else
      suma_fila(xs, col_idx + 1, fila_idx)
    end
  end

  # 2. Promedio de todos los números en la matriz

  def promedio_numeros(matriz) do
    {suma, cantidad} = recorrer_matriz(matriz, 0, 0)
    suma / cantidad
  end

  defp recorrer_matriz([], suma, cantidad), do: {suma, cantidad}

  defp recorrer_matriz([fila | resto], suma, cantidad) do
    {sum, cant} = acumular_fila(fila, suma, cantidad)
    recorrer_matriz(resto, sum, cant)
  end

  defp acumular_fila([], suma, cant), do: {suma, cant}

  defp acumular_fila([x | xs], suma, cant) do
    acumular_fila(xs, suma + x, cant + 1)
  end


end

Matriz.main()
