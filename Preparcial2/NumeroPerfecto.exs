defmodule NumeroPerfecto do

  def main do
    numero =
      "Ingrese un número: "
      |> Util.ingresar(:entero)

    if es_perfecto?(numero) do
      IO.puts("#{numero} es un número perfecto")
    else
      IO.puts("#{numero} NO es un número perfecto")
    end
  end

  def es_perfecto?(numero) when numero > 0 do
    divisores = obtener_divisores(numero, 1, [])
    sumar_divisores(divisores, 0) == numero
  end

  defp obtener_divisores(numero, i, acumulador) when i >= numero do
    acumulador
  end

  defp obtener_divisores(numero, i, acumulador) do
    if rem(numero, i) == 0 do
      obtener_divisores(numero, i + 1, [i | acumulador])
    else
      obtener_divisores(numero, i + 1, acumulador)
    end
  end

  defp sumar_divisores([], acumulador), do: acumulador

  defp sumar_divisores([head | tail], acumulador) do
    sumar_divisores(tail, acumulador + head)
  end

end

NumeroPerfecto.main()
