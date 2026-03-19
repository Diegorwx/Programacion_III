defmodule TamanoCajas do
  @moduledoc """
  Modulo que cálcula la combinación de cajas que use el menor número de cajas posible
  -Autor: Diego Alejandro Florez Serna
  -Fecha: 14/03/2026
  -Licencia: GNU GPL v3
  """

  def main do
    numero_productos =
      "Ingrese el número de productos a empacar: "
      |> Util.ingresar(:entero)

    resultado =
      calcular_cajas(numero_productos)

    IO.inspect(resultado)
  end

  def calcular_cajas(n) do
    cond do
      n < 0 or n > 1000 or rem(n, 10) != 0 ->
        {:error, "Cantidad no permitida"}

      true ->
        grandes = div(n, 100)
        resto1 = rem(n, 100)
        medianas = div(resto1, 50)
        pequenas = div(rem(resto1, 50), 10)
        {:ok, {pequenas, medianas, grandes}}
    end
  end
end

TamanoCajas.main()
