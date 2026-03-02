defmodule ValidadorUsuario do
  @moduledoc """
  Modulo que valida un nombre de usuario según ciertos criterios.
  - autor: Diego Alejandro Florez Serna
  - fecha: 01/03/2026
  - licencia: GNU GPL v3
  """

  def main do
    usuario =
      "Ingrese nombre de usuario: "
      |> Util.ingresar(:texto)

    resultado = validar(usuario)

    mostrar_resultado(resultado)
  end


  def validar(usuario) do
    errores = []
      |> validar_longitud(usuario)
      |> validar_minusculas(usuario)
      |> validar_espacios(usuario)
      |> validar_especiales(usuario)
      |> validar_letra(usuario)

    case errores do
      [] ->
        {:ok, "Usuario válido"}

      _ ->
        {:error, Enum.join(errores, " | ")}
    end
  end



  def validar_longitud(errores, usuario) do
    if String.length(usuario) >= 5 and String.length(usuario) <= 12 do
      errores
    else
      errores ++ ["Debe tener entre 5 y 12 caracteres"]
    end
  end


  def validar_minusculas(errores, usuario) do
    if usuario == String.downcase(usuario) do
      errores
    else
      errores ++ ["Debe estar completamente en minúscula"]
    end
  end


  def validar_espacios(errores, usuario) do
    if String.contains?(usuario, " ") do
      errores ++ ["No debe contener espacios"]
    else
      errores
    end
  end


  def validar_especiales(errores, usuario) do
    especiales = ["@", "#", "$", "%"]

    contiene =
      Enum.any?(especiales, fn c ->
        String.contains?(usuario, c)
      end)

    if contiene do
      errores ++ ["No debe contener caracteres especiales (@,#,$,%)"]
    else
      errores
    end
  end


  def validar_letra(errores, usuario) do
    solo_letras =
      usuario
      |> String.replace(~r/[^a-z]/, "")

    if String.length(solo_letras) >= 1 do
      errores
    else
      errores ++ ["Debe contener al menos una letra"]
    end
  end


  def mostrar_resultado({:ok, mensaje}) do
    Util.mostrar_mensaje(mensaje)
  end

  def mostrar_resultado({:error, mensaje}) do
    Util.mostrar_mensaje("Errores:")
    Util.mostrar_mensaje(mensaje)
  end

end


ValidadorUsuario.main()
