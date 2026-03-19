defmodule ImprimirMatrushka do
@moduledoc """
"""
  def main do
    imprimir_matrushka(5)
  end


  def imprimir_matrushhka(n) when n > 1 do
    for i <- 5..1 do
      IO.puts("Abriendo Matrushka #{i}")
    end
    for i <- 1..5 do
      IO.puts("Cerrando Matrushka #{i}")
    end
  end
end

ImprimirMatrushka.main()

"""
Recursividad es proceso de ida y un proceso de vuelta, es decir, se llama a la función a sí misma hasta
llegar a un caso base, y luego se regresa por cada llamada anterior. En este caso, el proceso de ida
es abrir las Matrushkas en orden descendente, y el proceso de vuelta es cerrar las Matrushkas en orden
ascendente.

-Contexto de ejecución
"""
