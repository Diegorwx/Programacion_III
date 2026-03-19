defmodule Matruska do
@moduledoc """
Modulo que imprime, abriendo Matruska 5 veces de orden descendente y despues cerrando Matrushka en orden ascendente
"""

  def imprimir_matruska(n) do
    if n > 0 do
      IO.puts("Abriendo Matruska #{n}")
      imprimir_matruska(n - 1)
      IO.puts("Cerrando Matruska #{n}")
    end
  end
end

Matruska.imprimir_matruska(5)
