defmodule Inventario do
  @archivo "productos.csv"

  def main do
    productos = cargar_productos()

    producto = registrar_producto()
    productos = Util.agregar(productos, producto)

    guardar_productos(productos)

    productos = actualizar_stock(productos, producto.codigo, -2)
    guardar_productos(productos)

    consultar_categoria(productos, producto.categoria)

    consultar_estado(productos)
  end

  # Registrar producto
  def registrar_producto do
    codigo = Util.ingresar("Código: ", :texto)
    nombre = Util.ingresar("Nombre: ", :texto)
    categoria = Util.ingresar("Categoría: ", :texto)
    precio = Util.ingresar("Precio: ", :real)
    stock = Util.ingresar("Cantidad en stock: ", :entero)

    fecha = Date.utc_today() |> Date.to_string()

    %Producto{
      codigo: codigo,
      nombre: nombre,
      categoria: categoria,
      precio: precio,
      stock: stock,
      fecha_entrada: fecha
    }
  end

  # Actualizar stock
  def actualizar_stock(productos, codigo, cambio) do
    Enum.map(productos, fn producto ->
      if producto.codigo == codigo do
        %{producto | stock: producto.stock + cambio}
      else
        producto
      end
    end)
  end

  # Consultar por categoría
  def consultar_categoria(productos, categoria) do
    Util.mostrar_mensaje("\nProductos de categoría: #{categoria}")

    productos
    |> Enum.filter(fn p -> p.categoria == categoria end)
    |> Enum.each(fn p ->
      IO.inspect(p)
    end)
  end

  # Estado inventario
  def consultar_estado(productos) do
    total_stock =
      Enum.reduce(productos, 0, fn p, acc ->
        acc + p.stock
      end)

    valor_total =
      Enum.reduce(productos, 0, fn p, acc ->
        acc + p.stock * p.precio
      end)

    Util.mostrar_mensaje("\nEstado del inventario")
    Util.mostrar_mensaje("Total unidades: #{total_stock}")
    Util.mostrar_mensaje("Valor total: $#{valor_total}")
  end

  # Guardar CSV
  def guardar_productos(productos) do
    contenido =
      "codigo,nombre,categoria,precio,stock,fecha_entrada\n" <>
        Enum.map_join(productos, "\n", fn p ->
          "#{p.codigo},#{p.nombre},#{p.categoria},#{p.precio},#{p.stock},#{p.fecha_entrada}"
        end)

    File.write(@archivo, contenido)
  end

  # Cargar CSV
  def cargar_productos do
    if File.exists?(@archivo) do
      {:ok, contenido} = File.read(@archivo)

      contenido
      |> String.split("\n", trim: true)
      |> Enum.drop(1)
      |> Enum.map(fn linea ->
        [codigo, nombre, categoria, precio, stock, fecha] =
          String.split(linea, ",")

        %Producto{
          codigo: codigo,
          nombre: nombre,
          categoria: categoria,
          precio: String.to_float(precio),
          stock: String.to_integer(stock),
          fecha_entrada: fecha
        }
      end)
    else
      []
    end
  end
end

Inventario.main()
