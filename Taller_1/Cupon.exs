defmodule ValidadorCupon do
  @moduledoc """
  Módulo que valida un código de cupón promocional
  - autor: Diego Alejandro Flórez Serna
  - fecha: 03/03/2026
  - licencia: GNU GPL v3
  """
  

  def main do
    cupon =
      "Ingrese el código del cupón: "
      |> Util.ingresar(:texto)

    resultado = validar(cupon)

    case resultado do
      {:ok, mensaje} ->
        Util.mostrar_mensaje(mensaje)

      {:error, mensaje} ->
        Util.mostrar_error(mensaje)
    end

    resultado
  end

  # Funciones individuales de validación
  defp validar_longitud(cupon) do
    if String.length(cupon) >= 10 do
      :ok
    else
      {:error, "el cupón debe tener al menos 10 caracteres"}
    end
  end

  defp validar_mayuscula(cupon) do
    if cupon != String.downcase(cupon) do
      :ok
    else
      {:error, "el cupón debe contener al menos una letra mayúscula"}
    end
  end

  defp validar_numero(cupon) do
    tiene_numero =
      ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
      |> Enum.any?(fn n -> String.contains?(cupon, n) end)

    if tiene_numero do
      :ok
    else
      {:error, "el cupón debe contener al menos un número"}
    end
  end

  defp validar_sin_espacios(cupon) do
    if String.replace(cupon, " ", "") == cupon do
      :ok
    else
      {:error, "el cupón no debe contener espacios"}
    end
  end

  # Acumula errores usando pipe
  defp acumular_errores(cupon) do
    [
      &validar_longitud/1,
      &validar_mayuscula/1,
      &validar_numero/1,
      &validar_sin_espacios/1
    ]
    |> Enum.map(fn validacion -> validacion.(cupon) end)
    |> Enum.filter(fn resultado -> resultado != :ok end)
    |> Enum.map(fn {:error, mensaje} -> mensaje end)
  end

  # Función principal pública
  def validar(cupon) do
    cupon
    |> acumular_errores()
    |> case do
      [] ->
        {:ok, "Cupón válido"}

      [unico_error] ->
        {:error, "El #{unico_error}"}

      errores ->
        mensaje =
          errores
          |> Enum.join(" y ")
          |> then(fn m -> "El #{m}" end)

        {:error, mensaje}
    end
  end
end

ValidadorCupon.main()
