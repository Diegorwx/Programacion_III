defmodule Pizzeria do
   @moduledoc """
  Módulo que simula el funcionamiento de una pizzería utilizando procesos ligeros en Elixir.
  """

  def main do
    pizzeria= spawn(fn -> loop() end)

    send(pizzeria, {:pedido, "Alejandro", "Pepperoni"})
    send(pizzeria, {:pedido, "Juan", "Hawaiana"})
    send(pizzeria, {:pedido, "Diana", "Cuatro quesos"})

    :timer.sleep(5000)

  end

  defp loop do
    receive do
      {:pedido, cliente, pizza} ->
        IO.puts(">>Pedido recibido de #{cliente}: #{pizza}")

        spawn(fn -> preparar_pizza(cliente, pizza) end)

        loop()
    end
  end

  defp preparar_pizza(cliente, pizza) do
    IO.puts("...Preparando pizza #{pizza} para #{cliente}...")
    :timer.sleep(2000)
    IO.puts("¡Pizza #{pizza} lista para #{cliente}!")
  end
end

Pizzeria.main()
