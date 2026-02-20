defmodule EntradaDatos do
  @moduledoc """
Módulo que retorna un mensaje de bienvenida personalizado
- autor: Diego Alejandro Florez Serna.
- fecha: 17/02/2026
- licencia: GNU GPL v3
"""
  def main do
    "Ingrese nombre del empleado: "
    |> ingresar_texto()
    |> generar_mensaje()
    |> Util.mostrar_mensaje()
  end

defp ingresar_texto(mensaje) do
    mensaje
    |>IO.gets()
    |>String.trim()
  end

  defp generar_mensaje(nombre) do
    "Bienvenido #{nombre} a la empresa Once Ltda"
  end
end

EntradaDatos.main()
