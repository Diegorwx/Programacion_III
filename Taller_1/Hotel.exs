defmodule HotelCosto do
  @moduledoc """
  Modulo que calcula el costo de reserva de un hotel
  - autor: Diego Alejandro Flórez Serna
  - fecha: 28/02/2026
  - licencia: GNU GPL v3
  """

  def main do
    numero_noches =
      "Ingrese el numero de noches: "
      |> Util.ingresar(:entero)

    tipo_cliente =
      "Ingrese el tipo de cliente (frecuente, corporativo, ocasional): "
      |> Util.ingresar(:texto)
      |> String.downcase()
      |> convertir_a_atomo()

    temporada =
      "Ingrese la temporada (alta, baja): "
      |> Util.ingresar(:texto)
      |> String.downcase()

    resultado = calcular(numero_noches, tipo_cliente, temporada)

    case resultado do
      {:ok, {tarifa, subtotal, descuento, recargo, total}} ->
        Util.mostrar_mensaje("Tarifa base por noche: #{tarifa}")
        Util.mostrar_mensaje("Subtotal sin descuentos ni recargos: #{subtotal}")
        Util.mostrar_mensaje("Valor del descuento: #{descuento}")
        Util.mostrar_mensaje("Valor del recargo: #{recargo}")
        Util.mostrar_mensaje("Total a pagar: #{total}")

      {:error, mensaje} ->
        Util.mostrar_mensaje("Error: #{mensaje}")
    end

    resultado
  end

  # Función principal que calcula el costo total
  def calcular(noches, tipo, temporada)
      when is_integer(noches) and noches > 0 and
             tipo in [:frecuente, :corporativo, :ocasional] and
             temporada in ["alta", "baja"] do
    tarifa = tarifa_base(noches)
    subtotal = noches * tarifa
    descuento = descuento_cliente(tipo, subtotal)
    subtotal_con_descuento = subtotal - descuento
    recargo = recargo_temporada(temporada, subtotal_con_descuento)
    total = subtotal_con_descuento + recargo

    {:ok, {tarifa, subtotal, descuento, recargo, total}}
  end

  # Validaciones de entrada con guards y pattern matching
  def calcular(noches, _, _) when not is_integer(noches) or noches <= 0,
    do: {:error, "El número de noches debe ser mayor que 0"}

  def calcular(_, tipo, _) when tipo not in [:frecuente, :corporativo, :ocasional],
    do: {:error, "Tipo de cliente inválido"}

  def calcular(_, _, temporada) when temporada not in ["alta", "baja"],
    do: {:error, "Temporada inválida"}

  # tarifa base por número de noches
  def tarifa_base(noches) when noches <= 2, do: 120_000
  def tarifa_base(noches) when noches <= 5, do: 100_000
  def tarifa_base(noches) when noches > 5, do: 85_000

  # descuento por tipo de cliente con atomos y pattern matching
  defp convertir_a_atomo("frecuente"), do: :frecuente
  defp convertir_a_atomo("corporativo"), do: :corporativo
  defp convertir_a_atomo("ocasional"), do: :ocasional
  defp convertir_a_atomo(_), do: :invalido

  def descuento_cliente(:frecuente, subtotal), do: subtotal * 0.20
  def descuento_cliente(:corporativo, subtotal), do: subtotal * 0.15
  def descuento_cliente(:ocasional, _subtotal), do: 0

  # recargo por temporada
  def recargo_temporada(temporada, subtotal) do
    cond do
      temporada == "alta" -> subtotal * 0.25
      temporada == "baja" -> 0
    end
  end
end

HotelCosto.main()
