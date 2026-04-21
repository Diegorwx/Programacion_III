defmodule ContarVocales do

  def main do
    IO.puts("Ingrese una cadena de texto:")
    texto = IO.gets("") |> String.trim()
    cantidad_vocales = contar_vocales(texto)
    IO.puts("La cantidad de vocales en la cadena es: #{cantidad_vocales}")
  end

  def contar_vocales(texto) do
    texto
    |> String.downcase()
    |> String.graphemes()
    |> contar_lista()
  end

  defp contar_lista([]), do: 0

  defp contar_lista (head | teil) do
    vocales= ["a", "e", "i", "o", "u"]

    if head in vocales do
      1 + contar_lista(teil)
    else
      contar_lista(teil)
    end
  end
end
