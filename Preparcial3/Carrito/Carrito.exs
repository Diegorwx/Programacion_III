defmodule Carrito do
  @archivo "carrito.csv"

  def main do
    items = cargar_carrito()

    carrito = spawn(fn -> loop(items) end)

    send(carrito, {:agregar_item, %Item{id: 1, nombre: "Mouse", cantidad: 2, precio_unitario: 50.0}})
    send(carrito, {:agregar_item, %Item{id: 2, nombre: "Teclado", cantidad: 1, precio_unitario: 120.0}})
    send(carrito, {:agregar_item, %Item{id: 1, nombre: "Mouse", cantidad: 1, precio_unitario: 50.0}})

    send(carrito, {:listar, self()})

    receive do
      {:lista, lista} ->
        Util.mostrar_mensaje("Items del carrito:")
        IO.inspect(lista)
    end

    send(carrito, {:total, self()})

    receive do
      {:resultado_total, total} ->
        Util.mostrar_mensaje("Total: #{total}")
    end

    send(carrito, :guardar_carrito)

    send(carrito, {:quitar_item, 2})

    send(carrito, {:listar, self()})

    receive do
      {:lista, lista} ->
        Util.mostrar_mensaje("Después de eliminar:")
        IO.inspect(lista)
    end

    send(carrito, :vaciar)

    send(carrito, {:listar, self()})

    receive do
      {:lista, lista} ->
        Util.mostrar_mensaje("Carrito vacío:")
        IO.inspect(lista)
    end

    send(carrito, :detener)
  end

  defp loop(items) do
    receive do
      {:agregar_item, nuevo} ->
        items_actualizados = agregar(items, nuevo)
        loop(items_actualizados)

      {:quitar_item, id} ->
        items_actualizados =
          Enum.filter(items, fn item -> item.id != id end)

        loop(items_actualizados)

      {:total, pid} ->
        total =
          Enum.reduce(items, 0, fn item, acc ->
            acc + item.cantidad * item.precio_unitario
          end)

        send(pid, {:resultado_total, total})
        loop(items)

      {:listar, pid} ->
        send(pid, {:lista, items})
        loop(items)

      :guardar_carrito ->
        guardar(items)
        Util.mostrar_mensaje("Carrito guardado.")
        loop(items)

      :vaciar ->
        Util.mostrar_mensaje("Carrito vaciado.")
        loop([])

      :detener ->
        Util.mostrar_mensaje("Carrito detenido.")
    end
  end

  defp agregar(items, nuevo) do
    existe = Enum.find(items, fn item -> item.id == nuevo.id end)

    if existe do
      Enum.map(items, fn item ->
        if item.id == nuevo.id do
          %Item{
            item
            | cantidad: item.cantidad + nuevo.cantidad
          }
        else
          item
        end
      end)
    else
      Util.agregar(items, nuevo)
    end
  end

  defp guardar(items) do
    contenido =
      "id,nombre,cantidad,precio_unitario\n" <>
        Enum.map_join(items, "\n", fn item ->
          "#{item.id},#{item.nombre},#{item.cantidad},#{item.precio_unitario}"
        end)

    File.write(@archivo, contenido)
  end

  defp cargar_carrito do
    if File.exists?(@archivo) do
      {:ok, contenido} = File.read(@archivo)

      contenido
      |> String.split("\n", trim: true)
      |> Enum.drop(1)
      |> Enum.map(fn linea ->
        [id, nombre, cantidad, precio] = String.split(linea, ",")

        %Item{
          id: String.to_integer(id),
          nombre: nombre,
          cantidad: String.to_integer(cantidad),
          precio_unitario: String.to_float(precio)
        }
      end)
    else
      []
    end
  end
end

Carrito.main()
