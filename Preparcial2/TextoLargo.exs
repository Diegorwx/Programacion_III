defmodule ListaCadenas do

  def main do
    lista = ["Hola", "Mundo", "Bienvenidos a Elixir", "Estamos aprendiendo ", "Genial", "Gorila"]

    resultado = mas_larga(lista)
    IO.puts("La cadena más larga es: #{resultado}")
  end

  def mas_larga([h]), do: h

  def mas_larga([h | t]) do
    comparar(h, mas_larga(t))
  end

  defp comparar(a, b) do
    if String.length(a) >= String.length(b) do
      a
    else
      b
    end
  end

end

ListaCadenas.main()
