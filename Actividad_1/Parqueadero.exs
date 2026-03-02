defmodule Parqueadero do
  @moduledoc """
  Modulo que calcula la tarifa de un parqueadero
  - autor: Diego Alejandro Florez Serna
  - fecha: 28/02/2026
  - licencia: GNU GPL v3
  """

  def main do
    horas =
      "Ingrese cuántas horas estará: "
      |> Util.ingresar(:entero)

    tipo_cliente =
      "Es cliente frecuente? 1=Si 2=No: "
      |> Util.ingresar(:entero)

    tipo_vehiculo =
      "Su vehículo es 1=Eléctrico 2=Convencional: "
      |> Util.ingresar(:entero)

    dia =
      "Es 1=Fin de semana o 2=Entre semana: "
      |> Util.ingresar(:entero)

    {sin_descuento, con_descuento} =
      calcular_total(horas, tipo_cliente, tipo_vehiculo, dia)

    mostrar_mensaje(sin_descuento, con_descuento)
  end



  def calcular_total(horas, tipo_cliente, tipo_vehiculo, dia) do
    base = tarifa_base(horas)
    final = aplicar_descuento(base, tipo_cliente, tipo_vehiculo, dia)
    {base, final}
  end


  def tarifa_base(horas) when horas <= 2, do: horas * 3000
  def tarifa_base(horas) when horas <= 5, do: 2 * 3000 + (horas - 2) * 2500
  def tarifa_base(horas) when horas <= 8, do: 2 * 3000 + 3 * 2500 + (horas - 5) * 2000
  def tarifa_base(horas) when horas > 8, do: 18000


  def aplicar_descuento(base, tipo_cliente, tipo_vehiculo, dia) do
    descuento_total = 0.0

    descuento_total =
      if tipo_cliente == 1 do
        descuento_total + 0.15
      else
        descuento_total
      end

    descuento_total =
      if tipo_vehiculo == 1 do
        descuento_total + 0.20
      else
        descuento_total
      end

    descuento_total =
      if dia == 1 do
        descuento_total + 0.10
      else
        descuento_total
      end

    base * (1 - descuento_total)
  end


  def mostrar_mensaje(base, final) do

    Util.mostrar_mensaje("Tarifa sin descuento: $#{base}")
    Util.mostrar_mensaje("Tarifa con descuento: $#{Float.round(final, 2)}")
  end
end

Parqueadero.main()
