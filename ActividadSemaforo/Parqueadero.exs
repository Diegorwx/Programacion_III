defmodule Parqueadero do
  def main do
    semaforo = spawn(fn -> semaforo(0) end)

    for i <- 1..15 do
      spawn(fn -> carro(semaforo, i) end)
    end


  end

  defp semaforo(cantidad) do
    receive do
      {:llegada, pid} ->
        if cantidad < 10 do
          send(pid, :puede_entrar)
          semaforo(cantidad + 1)
        else
          send(pid, :no_puede_entrar)
          semaforo(cantidad)
        end

      {:salida} ->
        semaforo(cantidad - 1)
    end
  end

  defp carro(semaforo, id) do
    send(semaforo, {:llegada, self()})

    receive do
      :puede_entrar ->
        IO.puts("Carro #{id} ha entrado al parqueadero.")
        Process.sleep(:rand.uniform(5000))
        send(semaforo, {:salida})
        IO.puts("Carro #{id} ha salido del parqueadero.")

      :no_puede_entrar ->
        IO.puts("Carro #{id} no pudo entrar al parqueadero.")
    end
  end
end

Parqueadero.main()
