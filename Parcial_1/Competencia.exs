defmodule Competencia do
  @moduledoc """
  Módulo que calcula el puntaje de una competencia de programación de dos rondas
  - Autor: Diego Alejandro Florez Serna
  - Fecha: 14/03/2026
  - Licencia: GNU GPL v3
  """

  def main do
    Util.mostrar_mensaje("---- RONDA 1 ----")
    ronda1 = rondan()

    Util.mostrar_mensaje("---- RONDA 2 ----")
    ronda2 = rondan()

    puntos1 = puntos_ronda(ronda1)
    puntos2 = puntos_ronda(ronda2)

    total = puntos1 + puntos2

    sin_resolver =
      contar_no_resueltos(ronda1) + contar_no_resueltos(ronda2)

    clasificacion = clasificacion(total, sin_resolver)

    Util.mostrar_mensaje("Puntos ronda 1: #{puntos1}")
    Util.mostrar_mensaje("Puntos ronda 2: #{puntos2}")
    Util.mostrar_mensaje("Puntaje total: #{total}")
    Util.mostrar_mensaje("Problemas sin resolver: #{sin_resolver}")
    Util.mostrar_mensaje("Clasificación final: #{clasificacion}")
  end


  def rondan do
    dificultad =
      "Ingrese dificultad (facil, medio, dificil): "
      |> Util.ingresar(:texto)

    resolvio =
      "¿Resolvió el problema? (si/no): "
      |> Util.ingresar(:texto)

    intentos =
      if resolvio == "si" do
        "Número de intentos (1,2,3): "
        |> Util.ingresar(:entero)
      else
        0
      end

    {dificultad, resolvio, intentos}
  end

  def puntos_base("facil"), do: 100
  def puntos_base("medio"), do: 250
  def puntos_base("dificil"), do: 500

  def multiplicador(intentos) when intentos == 1, do: 1.0
  def multiplicador(intentos) when intentos == 2, do: 0.75
  def multiplicador(intentos) when intentos == 3, do: 0.5


  def puntos_ronda({dif, "si", intentos}) do
    puntos_base(dif) * multiplicador(intentos)
  end

  def puntos_ronda({_dif, "no", _}) do
    -30
  end

  def contar_no_resueltos({_, "no", _}), do: 1
  def contar_no_resueltos({_ , "si", _}), do: 0

  def clasificacion(_, 2), do: "Eliminado"

  def clasificacion(puntaje, _) do
    cond do
      puntaje >= 600 -> "Oro"
      puntaje >= 400 -> "Plata"
      puntaje >= 200 -> "Bronce"
      true -> "Eliminado"
    end
  end
end

Competencia.main()
