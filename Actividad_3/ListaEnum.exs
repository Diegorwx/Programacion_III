defmodule Lista do
  def main do
    Resultado= procesar(["Elixir", "es", "un", "lenguaje", "funcional", "muy", "poderoso"])
    IO.puts ("Resultado: #{Resultado}")
  end

  def procesar(lista) do
    lista
    |> Enum.map(&String.upcase(&1))
    |> Enum.filter(fn w -> String.length(w) > 4 end)
    |> Enum.map(fn cadena -> String.reverse(cadena) end)
    |> Enum.sort()
    |> Enum.take(3)
    |> Enum.join(" - ")
  end

end

Lista.main()
