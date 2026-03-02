defmodule Aerolinea do
  @moduledoc """
  Modulo que calcula el costo de un tiquete aereo con cargos opcionales.
  - autor: Diego Alejandro Florez Serna
  - fecha: 01/03/2026
  - licencia: GNU GPL v3
  """

  def main do
    IO.puts("\nDestinos disponibles: bogota, medellin, cartagena, san_andres")
    destino_input = "Ingrese su destino: " |> Util.ingresar(:texto) |> String.downcase()

    case parsear_destino(destino_input) do
      {:error, mensaje} ->
        Util.mostrar_error(mensaje)

      {:ok, destino} ->
        silla =
          "Desea seleccionar silla? +$15.000 [s/n]: " |> Util.ingresar(:texto) |> opcion_bool()

        maleta =
          "Desea maleta de bodega?  +$45.000 [s/n]: " |> Util.ingresar(:texto) |> opcion_bool()

        seguro =
          "Desea seguro de viaje?   +$12.000 [s/n]: " |> Util.ingresar(:texto) |> opcion_bool()

        destino
        |> calcular_total(silla, maleta, seguro)
        |> mostrar_resultado(destino)
    end
  end

  def calcular_total(destino, silla, maleta, seguro) do
    {maleta_final, aviso} =
      if maleta_obligatoria?(destino),
        do: {true, "Maleta de bodega agregada automaticamente (obligatoria para San Andres)"},
        else: {maleta, nil}

    total =
      total =
      tarifa_base(destino) + cargo_silla(silla) + cargo_maleta(maleta_final) +
        cargo_seguro(seguro)

    {:ok,
     %{
       destino: destino,
       base: tarifa_base(destino),
       silla: silla,
       maleta: maleta_final,
       seguro: seguro,
       total: total,
       aviso: aviso
     }}
  end

  def mostrar_resultado({:ok, r}, _destino) do
    IO.puts("       RESUMEN DE COMPRA      ")
    IO.puts("══════════════════════════════")
    IO.puts("Destino       : #{r.destino}")
    IO.puts("Tiquete base  : $#{r.base}")
    if r.silla, do: IO.puts("Selec. silla  : $15.000")
    if r.maleta, do: IO.puts("Maleta bodega : $45.000")
    if r.seguro, do: IO.puts("Seguro viaje  : $12.000")
    IO.puts("──────────────────────────────")
    Util.mostrar_mensaje("TOTAL: $#{r.total}")
    if r.aviso, do: Util.mostrar_error(r.aviso)
  end

  # Pattern matching tarifas base
  defp tarifa_base(:bogota), do: 180_000
  defp tarifa_base(:medellin), do: 210_000
  defp tarifa_base(:cartagena), do: 320_000
  defp tarifa_base(:san_andres), do: 450_000

  # Pattern matching cargos
  defp cargo_silla(true), do: 15_000
  defp cargo_silla(false), do: 0

  defp cargo_maleta(true), do: 45_000
  defp cargo_maleta(false), do: 0

  defp cargo_seguro(true), do: 12_000
  defp cargo_seguro(false), do: 0

  # Guard maleta obligatoria
  defp maleta_obligatoria?(destino) when destino == :san_andres, do: true
  defp maleta_obligatoria?(_), do: false

  defp parsear_destino("bogota"), do: {:ok, :bogota}
  defp parsear_destino("medellin"), do: {:ok, :medellin}
  defp parsear_destino("cartagena"), do: {:ok, :cartagena}
  defp parsear_destino("san_andres"), do: {:ok, :san_andres}
  defp parsear_destino(_), do: {:error, "Destino no valido"}

  defp opcion_bool(input), do: String.trim(input) |> String.downcase() == "s"
end

Aerolinea.main()
