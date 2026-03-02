defmodule ListasElixir do
  @moduledoc """
  Módulo que muestra ejemplos de listas en Elixir
  y algunos casos prácticos de uso
  - autor: Diego Alejandro Florez Serna.
  - fecha: 25/02/2026
  - licencia: GNU GPL v3
  """
  ### CREACIÓN DE LISTAS ###

  # Lista vacía
  []

  # Lista de números
  lista = [1, 2, 3, 4]
  [5 | lista]
  [1, 2, 3] ++ [4, 5, 6]
  [1, 2, 3] -- [2, 3]

  ### ACCESO A ELEMENTOS DE UNA LISTA ###
  lista = [10, 20, 30, 40, 50]
  [x | _] = lista


  Enum.at([1, 2, 3, 4, 5, 6, 7, 8], 5)
  Enum.at(["a", "b", "c", "d"], 0)

  # List.first y List.last
  List.first([1, 2, 3, 4])
  List.last([1, 2, 3, 4])

  ### MANIPULACIÓN DE LISTAS ###
  List.insert_at(["a", "b", "c", "d"], 2, "hola")
  List.delete_at(["a", "b", "c", "d"], 1)
  List.replace_at(["a", "b", "c", "d"], 1, "mundo")

  # Número de elementos
  length(["a", "b", "c", "d"])



  
end
