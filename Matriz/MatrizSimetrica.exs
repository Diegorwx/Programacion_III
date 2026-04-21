defmodule MatrizSimetrica do
  def main do
    matriz = [
      [1, 2, 3],
      [2, 5, 6],
      [3, 6, 9]
    ]

    if simetrica?(matriz) do
      IO.puts("La matriz es simétrica")
    else
      IO.puts("La matriz NO es simétrica")
    end
  end

  def simetrica?(matriz) do
    verificar_filas(matriz, matriz, 0)
  end

  # Caso base: sin filas → es simétrica
  defp verificar_filas([], _, _), do: true

  defp verificar_filas([fila | resto], matriz, i) do
    if verificar_columnas(fila, matriz, i, 0) do
      verificar_filas(resto, matriz, i + 1)
    else
      false
    end
  end

  # Verifica cada elemento de la fila
  defp verificar_columnas([], _, _, _), do: true

  defp verificar_columnas([valor | vals], matriz, i, j) do
    if valor == get_in(matriz, [Access.at(j), Access.at(i)]) do
      verificar_columnas(vals, matriz, i, j + 1)
    else
      false
    end
  end
end

MatrizSimetrica.main()
