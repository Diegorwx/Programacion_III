defmodule DataSensor do
  def main do
    sensores = [
      %Sensor{id: 1, zona: "Producción", temperaturas: [30, 31, 29, 32, 30]},
      %Sensor{id: 2, zona: "Empaque", temperaturas: [25, 26, 27, 25, 24]},
      %Sensor{id: 3, zona: "Almacenamiento", temperaturas: [18, 19, 20, 18, 17]},
      %Sensor{id: 4, zona: "Calderas", temperaturas: [50, 52, 49, 51, 53]}
    ]

    tareas =
      Enum.map(sensores, fn sensor ->
        Task.async(fn ->
          {sensor.id, sensor.zona, procesar_sensor(sensor)}
        end)
      end)

    resultados = Enum.map(tareas, &Task.await/1)

    Util.mostrar_mensaje("RESULTADOS DEL ANÁLISIS")

    Enum.each(resultados, fn {id, zona, {:ok, promedio}} ->
      Util.mostrar_mensaje(
        "Sensor #{id} | Zona: #{zona} | Promedio: #{Float.round(promedio, 2)} °C"
      )
    end)
  end

  def procesar_sensor(sensor) do
    suma = Enum.sum(sensor.temperaturas)
    cantidad = length(sensor.temperaturas)

    promedio = suma / cantidad

    {:ok, promedio}
  end
end

DataSensor.main()
