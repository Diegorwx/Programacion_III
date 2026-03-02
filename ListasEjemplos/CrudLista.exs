defmodule CrudLista do
   @moduledoc """
Módulo que muestra un CRUD básico y otras funciones, para listas en Elixir
- autor: Diego Alejandro Florez Serna.
- fecha: 25/02/2026
- licencia: GNU GPL v3
"""

  #Constantes
  @pi 3.1416

  # CRUD de lista
  def agregar(lista, elemento) do
    Util.agregar(lista, elemento)
  end

  def mostrar(lista) do
    Util.mostrar_lista(lista)
  end

  def actualizar(lista, viejo, nuevo) do
    Util.actualizar(lista, viejo, nuevo)
  end

  def eliminar(lista, elemento) do
    Util.eliminar(lista, elemento)
  end

  # RECORRER lista manualmente
  def recorrer(lista) do
    Enum.each(lista, fn elemento ->
      IO.puts("Elemento: #{elemento}")
    end)
  end

  # OBTENER tamaño
  def tamaño(lista) do
    length(lista)
  end

  # OBTENER elemento por índice
  def obtener_por_indice(lista, indice) do
    Enum.at(lista, indice)
  end

  # REEMPLAZAR por índice
  def reemplazar_por_indice(lista, indice, nuevo_valor) do
    List.replace_at(lista, indice, nuevo_valor)
  end

  def main do
    lista = ["Luffy", "Zoro", "Nami"]

    IO.puts("Lista inicial:")
    mostrar(lista)

    lista = agregar(lista, "Sanji")

    IO.puts("\nDespués de agregar:")
    mostrar(lista)

    lista = actualizar(lista, "Zoro", "Robin")

    IO.puts("\nDespués de actualizar:")
    mostrar(lista)

    lista = eliminar(lista, "Nami")

    IO.puts("\nDespués de eliminar:")
    mostrar(lista)

    IO.puts("\nRecorriendo lista:")
    recorrer(lista)

    IO.puts("\nTamaño de la lista:")
    IO.puts(tamaño(lista))

    IO.puts("\nElemento en posición 1:")
    IO.puts(obtener_por_indice(lista, 1))

    lista = reemplazar_por_indice(lista, 1, "Usopp")

    IO.puts("\nDespués de reemplazar por índice:")
    mostrar(lista)

  end
end

CrudLista.main()
