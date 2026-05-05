defmodule Parqueadero do
  def main do
    semaforo = spawn(fn -> semaforo(0, []) end)

    for i <- 1..10 do
      spawn(fn -> carro(semaforo, i) end)
      Process.sleep(200)
    end

    # Dar tiempo a que todos los carros terminen de ingresar
    Process.sleep(20_000)
  end

  # ─── Semáforo con lista de espera ───────────────────────────────
  defp semaforo(cantidad, espera) do
    receive do
      {:llegada, pid, id} ->
        if cantidad < 5 do
          send(pid, :puede_entrar)
          IO.puts("  [Parqueadero] Ocupados: #{cantidad + 1}/5 | En espera: #{length(espera)}")
          semaforo(cantidad + 1, espera)
        else
          IO.puts("  [Parqueadero] Lleno. Carro #{id} pasa a lista de espera. En espera: #{length(espera) + 1}")
          semaforo(cantidad, espera ++ [{pid, id}])
        end

      {:salida, id} ->
        IO.puts("  [Parqueadero] Carro #{id} liberó un espacio.")
        case espera do
          [] ->
            IO.puts("  [Parqueadero] Ocupados: #{cantidad - 1}/5 | Sin espera")
            semaforo(cantidad - 1, [])

          [{pid_siguiente, id_siguiente} | resto] ->
            IO.puts("  [Parqueadero] Carro #{id_siguiente} sale de la espera e ingresa.")
            send(pid_siguiente, :puede_entrar)
            IO.puts("  [Parqueadero] Ocupados: #{cantidad}/5 | En espera: #{length(resto)}")
            semaforo(cantidad, resto)
        end
    end
  end

  # ─── Proceso carro ───────────────────────────────────────────────
  defp carro(semaforo, id) do
    send(semaforo, {:llegada, self(), id})

    receive do
      :puede_entrar ->
        IO.puts("🚗 Carro #{id} ENTRÓ al parqueadero.")
        tiempo = 3000 + :rand.uniform(5000)
        Process.sleep(tiempo)
        send(semaforo, {:salida, id})
        IO.puts("🚗 Carro #{id} SALIÓ del parqueadero. (estuvo #{tiempo}ms)")

    after
      # Si no recibe respuesta en 5s, reintenta
      5000 ->
        IO.puts("⏳ Carro #{id} sigue esperando...")
        carro(semaforo, id)
    end
  end
end

Parqueadero.main()
