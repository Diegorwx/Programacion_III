defmodule CarreraCerditos do
  @meta 50

  def main do
    principal = self()

    cerditos = [
      spawn(fn -> correr(principal, "Cerdito 1", 0) end),
      spawn(fn -> correr(principal, "Cerdito 2", 0) end),
      spawn(fn -> correr(principal, "Cerdito 3", 0) end),
      spawn(fn -> correr(principal, "Cerdito 4", 0) end)
    ]

    posiciones = %{
      "Cerdito 1" => 0,
      "Cerdito 2" => 0,
      "Cerdito 3" => 0,
      "Cerdito 4" => 0
    }

    Util.mostrar_mensaje("🐷 INICIA LA CARRERA 🐷")

    monitor(posiciones, cerditos)
  end

  defp correr(principal, nombre, posicion) do
    receive do
      :detener ->
        :ok
    after
      :rand.uniform(400) + 100 ->
        avance = :rand.uniform(3)
        nueva_posicion = posicion + avance

        send(principal, {:avance, nombre, nueva_posicion})

        if nueva_posicion >= @meta do
          send(principal, {:ganador, nombre})
        else
          correr(principal, nombre, nueva_posicion)
        end
    end
  end

  defp monitor(posiciones, cerditos) do
    receive do
      {:avance, nombre, posicion} ->
        nuevas_posiciones = Map.put(posiciones, nombre, posicion)

        imprimir_pista(nuevas_posiciones)

        monitor(nuevas_posiciones, cerditos)

      {:ganador, nombre} ->
        Enum.each(cerditos, fn pid ->
          send(pid, :detener)
        end)

        Util.mostrar_mensaje("\n🏆 ¡#{nombre} ha ganado la carrera! 🏆")
    end
  end

  defp imprimir_pista(posiciones) do
    IO.write("\e[H\e[2J")

    Enum.each(posiciones, fn {nombre, pos} ->
      espacios = String.duplicate(" ", pos)
      pista = espacios <> "🐷"
      IO.puts("#{nombre}: #{pista}")
    end)

    IO.puts(String.duplicate("-", @meta + 15))
  end
end

CarreraCerditos.main()
