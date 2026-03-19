defmodule CostoEnvio do
  @moduledoc """
  Modulo que calcula el costo de envío de un paquete
  Autor: Diego Alejandro Florez Serna
  Fecha: 04/03/2026
  Licencia: GNU GPL v3
  """

  def main do
    peso_paquete =
      "Ingrese el peso del paquete en kg: "
      |> Util.ingresar(:real)

    tipo_cliente =
      "Ingrese el tipo de cliente (1=corporativo, 2=estudiante, 3=regular): "
      |> Util.ingresar(:entero)

    tipo_servicio =
      "Ingrese el tipo de servicio (4=express, 5=estándar): "
      |> Util.ingresar(:entero)

    costo_envio = calcular_costo_envio(peso_paquete, tipo_cliente, tipo_servicio)

    mostrar_resultado(costo_envio)
  end

  def calcular_costo_envio(peso, cliente, servicio) do
    costo_peso = peso_paquete(peso)

    descuento_cliente = tipo_cliente(cliente, costo_peso)

    subtotal = costo_peso - descuento_cliente

    recargo_servicio = tipo_servicio(servicio, costo_peso)

    subtotal + recargo_servicio
  end

  def peso_paquete(peso) when peso > 0 and peso <= 1, do: 8000
  def peso_paquete(peso) when peso > 1 and peso <= 5, do: 12000
  def peso_paquete(peso) when peso > 5, do: 20000
  def peso_paquete(_), do: {:error, "Peso no válido"}

  def tipo_cliente(1, costo), do: 0.15 * costo
  def tipo_cliente(2, costo), do: 0.10 * costo
  def tipo_cliente(3, _), do: 0
  def tipo_cliente(_, _), do: {:error, "Tipo de cliente no válido"}

  def tipo_servicio(4, costo), do: 0.25 * costo
  def tipo_servicio(5, _), do: 0
  def tipo_servicio(_, _), do: {:error, "Tipo de servicio no válido"}


  def mostrar_resultado({:error, mensaje}) do
    Util.mostrar_error(mensaje)
  end

  def mostrar_resultado(costo) do
  IO.puts("El costo total del envío es: #{costo}")
  end
end

CostoEnvio.main()
