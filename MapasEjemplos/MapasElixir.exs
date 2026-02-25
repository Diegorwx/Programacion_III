defmodule MapasElixir do
  @moduledoc """
  Módulo que muestra ejemplos de mapas en Elixir
  y algunos casos prácticos de uso
  - autor: Diego Alejandro Florez Serna.
  - fecha: 21/02/2026
  - licencia: GNU GPL v3
  """

  ### CREACIÓN DE MAPAS ###

  # Mapa vacío
  %{}

  # Mapa con átomos como claves
  persona = %{nombre: "Juan", edad: 25, ciudad: "Madrid"}

  # Mapa con strings como claves
  config = %{"host" => "localhost", "port" => 8080}

  # Mapa mixto (no recomendado, pero posible)
  mixto = %{:nombre => "Ana", "apellido" => "García"}

  ### ACCESO A VALORES EN MAPAS ###
  persona = %{nombre: "Juan", edad: 25}

  # Con átomos - sintaxis con punto
  # "Juan"
  persona.nombre
  # 25
  persona.edad

  # Con corchetes (funciona con cualquier tipo de clave)
  # "Juan"
  persona[:nombre]
  # "localhost"
  config["host"]

  # Con Map.get (retorna nil si no existe)
  # "Juan"
  Map.get(persona, :nombre)
  # nil
  Map.get(persona, :telefono)
  # "N/A" (valor por defecto)
  Map.get(persona, :telefono, "N/A")

  ### ACTUALIZACIÓN DE MAPAS###

  persona = %{nombre: "Juan", edad: 25}

  # Actualizar clave existente (solo con átomos)
  persona_mayor = %{persona | edad: 26}
  # %{nombre: "Juan", edad: 26}

  # Agregar o actualizar cualquier clave
  persona_completa = Map.put(persona, :ciudad, "Barcelona")
  # %{nombre: "Juan", edad: 25, ciudad: "Barcelona"}

  # Actualizar múltiples valores
  Map.merge(persona, %{edad: 26, ciudad: "Madrid"})
  # %{nombre: "Juan", edad: 26, ciudad: "Madrid"}

  #### ELIMINACIÓN DE CLAVES EN MAPAS ###

  persona = %{nombre: "Juan", edad: 25, ciudad: "Madrid"}

  # Eliminar clave con Map.delete
  Map.delete(persona, :ciudad)
  # %{nombre: "Juan", edad: 25}

  ### ITERACIÓN SOBRE MAPAS ###

  datos = %{a: 1, b: 2, c: 3}

  # Con Enum.map - transformar
  Enum.map(datos, fn {k, v} -> {k, v * 2} end)
  # [a: 2, b: 4, c: 6]

  # Con Enum.each - solo iterar
  Enum.each(datos, fn {k, v} ->
    IO.puts("#{k}: #{v}")
  end)

  # Solo las claves
  # [:a, :b, :c]
  Map.keys(datos)

  # Solo los valores
  # [1, 2, 3]
  Map.values(datos)

  ### EJEMPLOS PRÁCTICOS DE USO DE MAPAS ###

  # Usuario
  usuario = %{
    id: 1,
    nombre: "María",
    email: "maria@example.com",
    activo: true
  }

  # Verificar si existe una clave
  # true
  Map.has_key?(usuario, :email)
  # false
  Map.has_key?(usuario, :edad)

  # Producto en tienda
  producto = %{
    nombre: "Laptop",
    precio: 999.99,
    stock: 5
  }

  # Aplicar descuento
  producto_descuento = %{producto | precio: producto.precio * 0.9}

  # Configuración de app
  config = %{
    database: %{
      host: "localhost",
      port: 5432,
      nombre: "mi_db"
    },
    server: %{
      puerto: 4000
    }
  }

  # Acceder a mapas anidados
  # "localhost"
  config.database.host
  # "localhost"
  get_in(config, [:database, :host])

  # Actualizar mapa anidado
  put_in(config, [:database, :port], 5433)

  ### PATTERN MATCHING CON MAPAS ###

  %{nombre: nombre, edad: edad} = %{nombre: "Juan", edad: 25, ciudad: "Madrid"}
  # "Juan"
  nombre
  # 25
  edad

  # Función que recibe mapa
  def saludar(%{nombre: nombre}), do: "Hola #{nombre}"
  # "Hola Ana"
  saludar(%{nombre: "Ana", edad: 30})
end
