defmodule CalcularDevuelta do
  @moduledoc """
Módulo que calcula la devuelta de un pago
- autor: Diego Alejandro Florez Serna.
- fecha: 17/02/2026
- licencia: GNU GPL v3
"""

  def main do
    valor_total = "Ingrese el total de la compra: "
    |> ingresar(:entero)

    valor_pago = "Ingrese el valor del pago: "
    |> ingresar(:entero)

    calcular_devuelta(valor_pago, valor_total)
    |> generar_mensaje()
    |> Util.mostrar_mensaje()
  end

  defp ingresar(mensaje, :entero) do
    mensaje
    |> Util.ingresar(:texto)
    |> String.to_integer()
  end

  defp calcular_devuelta(valor_pago, valor_total) do
    valor_pago - valor_total
  end

  defp generar_mensaje(devuelta) do
    "El valor de devuelta es $ #{devuelta}"
  end
end

CalcularDevuelta.main()
