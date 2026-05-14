defmodule TransLogix do
  def main do
    servidor = spawn(fn -> servidor() end)

    envio = %Envio{
      id: "ENV001",
      tipo: "INTERNACIONAL",
      distancia: 1500,
      costo_base: 200
    }

    send(servidor, {:calcular, self(), envio})

    receive do
      {:resultado, costo} ->
        Util.mostrar_mensaje("Costo total del envío: $#{costo}")
    end
  end

  def servidor do
    receive do
      {:calcular, cliente, envio} ->
        costo = calcular_costo(envio)

        send(cliente, {:resultado, costo})

        servidor()
    end
  end

  def calcular_costo(envio) do
    case envio.tipo do
      "NACIONAL" ->
        envio.costo_base + envio.distancia * 0.5

      "INTERNACIONAL" ->
        envio.costo_base + envio.distancia * 1.2
    end
  end
end

TransLogix.main()
