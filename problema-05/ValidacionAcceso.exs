Code.require_file("util.ex", __DIR__)

defmodule Plataforma do
  @moduledoc """
  Modulo que valida el acceso a una plataforma virtual.
  - autor: Diego Alejandro Florez Serna.
  - fecha: 24/02/2026
  - licencia: GNU GPL v3
  """

  def main do
    usuario = "Ingrese el nombre de usuario: " |> Util.ingresar(:texto)
    edad = "Ingrese la edad: " |> Util.ingresar(:entero)
    credenciales = "Ingrese las credenciales: " |> Util.ingresar(:texto)
    intentos = "Ingrese el numero de intentos fallidos: " |> Util.ingresar(:entero)

    usuario
    |> validar_acceso(edad, credenciales, intentos)
    |> mostrar_resultado()
  end

  def validar_acceso(usuario, edad, credenciales, intentos) do
    cond do
      String.trim(credenciales) == "" ->
        {:error, "Acceso denegado: El usuario #{usuario} tiene credenciales invalidas"}

      edad < 18 ->
        {:error, "Acceso denegado: Usuario menor de edad"}

      intentos >= 3 ->
        {:error, "Acceso denegado: El numero de intentos no puede ser mayor a 3"}

      true ->
        {:ok, "Acceso concedido para #{usuario}. Intentos fallidos registrados: #{intentos}"}
    end
  end

  def mostrar_resultado({:ok, mensaje}) do
    Util.mostrar_mensaje(mensaje)
  end

  def mostrar_resultado({:error, mensaje}) do
    Util.mostrar_error(mensaje)
  end
end

Plataforma.main()
