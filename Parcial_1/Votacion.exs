defmodule ValidarVoto do
  @moduledoc """
  Valida un voto estudiantil
  - Autor: Diego Alejandro Florez Serna
  - Fecha: 14/03/2026
  - Licencia: GNU GPL v3
  """

  def main do
    candidato =
      "Ingrese candidato (A,B,C): "
      |> Util.ingresar(:texto)
      |> String.trim()
      |> String.upcase()
      |> convertir_candidato()

    codigo =
      "Ingrese código (8 dígitos): "
      |> Util.ingresar(:texto)
      |> String.trim()

    jornada =
      "Ingrese jornada (diurna/nocturna): "
      |> Util.ingresar(:texto)
      |> String.trim()
      |> String.downcase()
      |> convertir_jornada()

    voto = {candidato, codigo, jornada}

    case validar_voto(voto) do
      {:ok, mensaje} ->
        Util.mostrar_mensaje(mensaje)

      {:error, errores} ->
        Util.mostrar_mensaje("Errores: #{Enum.join(errores,", ")}")
    end
  end  

  def convertir_candidato("A"), do: :candidato_a
  def convertir_candidato("B"), do: :candidato_b
  def convertir_candidato("C"), do: :candidato_c
  def convertir_candidato(_), do: :invalido

  def convertir_jornada("diurna"), do: :diurna
  def convertir_jornada("nocturna"), do: :nocturna
  def convertir_jornada(_), do: :invalido


  def validar_voto({candidato, codigo, jornada}) do
    errores =
      []
      |> validar_candidato(candidato)
      |> validar_codigo(codigo)
      |> validar_jornada(jornada)

    case errores do
      [] -> {:ok, "Voto registrado"}
      _ -> {:error, errores}
    end
  end

  def validar_candidato(lista, :candidato_a), do: lista
  def validar_candidato(lista, :candidato_b), do: lista
  def validar_candidato(lista, :candidato_c), do: lista
  def validar_candidato(lista, _), do: lista ++ ["Candidato inválido"]


  def validar_codigo(lista, codigo) do
    cond do
      String.length(codigo) != 8 ->
        lista ++ ["El código debe tener 8 dígitos"]

      !Regex.match?(~r/^\d+$/, codigo) ->
        lista ++ ["El código debe contener solo números"]

      true ->
        lista
    end
  end


  def validar_jornada(lista, :diurna), do: lista
  def validar_jornada(lista, :nocturna), do: lista
  def validar_jornada(lista, _), do: lista ++ ["Jornada inválida"]
end

ValidarVoto.main()
