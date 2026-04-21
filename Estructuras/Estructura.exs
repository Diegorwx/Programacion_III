defmodule Estructura do
  def main do
    "\nIngrese los datos del cliente: "
    |> Cliente.ingresar(:clientes)
    |> Cliente.generar_mensaje_clientes(&generar_mensaje/1)
    |> Util.mostrar_mensaje()
    crear_lista_clientes()
    |> Cliente.escribir_csv("clientes.csv")
  end

  defp generar_mensaje(cliente) do
    altura = cliente.altura |> Float.round(2)

    "Hola #{cliente.nombre}, tu edad es de #{cliente.edad} años y " <>
      "tienes una altura de #{altura}\n"
  end

  defp crear_lista_clientes do
    [
      Cliente.crear("Ana", 16, 1.70),
      Cliente.crear("Juan", 20, 1.72),
      Cliente.crear("Diana", 48, 1.80),
      Cliente.crear("Ana", 28, 1.70)
    ]
  end
end

Estructura.main()
