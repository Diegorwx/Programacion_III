defmodule Util do
  @moduledoc """
  Módulo con funciones que se reutilizan
  - autor: Nombre del autor.
  - fecha: fecha creación
  - licencia: GNU GPL v3
  """

  # MENSAJES

  def mostrar_mensaje(mensaje) do
    mensaje
    |> IO.puts()
  end

  def mostrar_error(mensaje) do
    IO.puts(:standard_error, mensaje)
  end

  # INGRESO DE DATOS

  def ingresar(mensaje, :texto) do
    mensaje
    |> IO.gets()
    |> String.trim()
  end

  def ingresar(mensaje, :entero) do
    try do
      mensaje
      |> ingresar(:texto)
      |> String.to_integer()
    rescue
      ArgumentError ->
        "Error, se espera que ingrese un número entero\n"
        |> mostrar_error()

        mensaje
        |> ingresar(:entero)
    end
  end

  def ingresar(mensaje, :real) do
    try do
      mensaje
      |> ingresar(:texto)
      |> String.to_float()
    rescue
      ArgumentError ->
        "Error, se espera que ingrese un número real\n"
        |> mostrar_error()

        mensaje
        |> ingresar(:real)
    end
  end

  ### FUNCIONES PARA LISTAS (CRUD) ###

  # CREATE
  def agregar(lista, elemento) do
    lista ++ [elemento]
  end

  # READ
  def mostrar_lista(lista) do
    Enum.each(lista, fn elemento ->
      IO.puts(elemento)
    end)
  end

  # UPDATE
  def actualizar(lista, viejo, nuevo) do
    Enum.map(lista, fn elemento ->
      if elemento == viejo do
        nuevo
      else
        elemento
      end
    end)
  end

  # DELETE
  def eliminar(lista, elemento) do
    Enum.filter(lista, fn e -> e != elemento end)
  end

  # BUSCAR
  def buscar(lista, elemento) do
    Enum.member?(lista, elemento)
  end

  def obtener_hora do
    {{_, _, _}, {hora, _, _}} = :calendar.local_time()
    hora
  end
end
