defmodule Estructura do
  def main do
    "Docentes_Uniquindio_20260421.csv"
    |> CSV.leer_csv(&Docente.convertir_cadena_docente/1)
    |> filtrar_datos_interes()
    |> CSV.generar_mensaje_csv(&generar_mensaje/1)
    |> Util.mostrar_mensaje()
  end

  defp generar_mensaje(docente) do
    "#{docente.periodo}, #{docente.formacion}, #{docente.vinculacion}"
  end

  def filtrar_datos_interes(datos) do
    datos
    |> Enum.filter(&(&1.formacion == "MAESTRIA" and &1.vinculacion == "PLANTA"))
  end

end

Estructura.main()
