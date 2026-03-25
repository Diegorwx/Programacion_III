vuelos = [
  %{
    codigo: "AV201",
    aerolinea: "Avianca",
    origen: "BOG",
    destino: "MDE",
    duracion: 45,
    precio: 180_000,
    pasajeros: 120,
    disponible: true
  },
  %{
    codigo: "LA305",
    aerolinea: "Latam",
    origen: "BOG",
    destino: "CLO",
    duracion: 55,
    precio: 210_000,
    pasajeros: 98,
    disponible: true
  },
  %{
    codigo: "AV410",
    aerolinea: "Avianca",
    origen: "MDE",
    destino: "CTG",
    duracion: 75,
    precio: 320_000,
    pasajeros: 134,
    disponible: false
  },
  %{
    codigo: "VV102",
    aerolinea: "Viva Air",
    origen: "BOG",
    destino: "BAQ",
    duracion: 90,
    precio: 145_000,
    pasajeros: 180,
    disponible: true
  },
  %{
    codigo: "LA512",
    aerolinea: "Latam",
    origen: "CLO",
    destino: "CTG",
    duracion: 110,
    precio: 480_000,
    pasajeros: 76,
    disponible: false
  },
  %{
    codigo: "AV330",
    aerolinea: "Avianca",
    origen: "BOG",
    destino: "CTG",
    duracion: 135,
    precio: 520_000,
    pasajeros: 155,
    disponible: true
  },
  %{
    codigo: "VV215",
    aerolinea: "Viva Air",
    origen: "MDE",
    destino: "BOG",
    duracion: 50,
    precio: 130_000,
    pasajeros: 190,
    disponible: true
  },
  %{
    codigo: "LA620",
    aerolinea: "Latam",
    origen: "BOG",
    destino: "MDE",
    duracion: 145,
    precio: 390_000,
    pasajeros: 112,
    disponible: true
  },
  %{
    codigo: "AV505",
    aerolinea: "Avianca",
    origen: "CTG",
    destino: "BOG",
    duracion: 120,
    precio: 440_000,
    pasajeros: 143,
    disponible: false
  },
  %{
    codigo: "VV340",
    aerolinea: "Viva Air",
    origen: "BAQ",
    destino: "BOG",
    duracion: 85,
    precio: 160_000,
    pasajeros: 175,
    disponible: true
  }
]

resultado =
  vuelos
  |> Enum.filter(fn %{disponible: disponible} ->
    disponible == true
  end)
  |> Enum.map(fn %{codigo: codigo} -> codigo end)
  |> Enum.sort()
  |> Enum.join(", ")

IO.puts(resultado)

resultado2 =
  vuelos
  |> Enum.group_by(& &1.aerolinea)
  |> Enum.map(fn {aerolinea, lista_vuelos} ->
    total_pasajeros =
      Enum.reduce(lista_vuelos, 0, fn vuelo, acc ->
        acc + vuelo.pasajeros
      end)

    {aerolinea, total_pasajeros}
  end)

IO.inspect(resultado2)

resultado3 =
  vuelos
  |> Enum.map(fn vuelo ->
    horas = div(vuelo.duracion, 60)
    minutos = rem(vuelo.duracion, 60)

    minutos_formateados =
      if minutos < 10 do
        "0#{minutos}"
      else
        "#{minutos}"
      end

    "#{vuelo.codigo} — #{vuelo.origen} → #{vuelo.destino}: #{horas}h #{minutos_formateados}m"
  end)

IO.inspect(resultado3)

limite = 400_000

resultado4 =
  vuelos
  |> Enum.filter(&(&1.precio < limite))
  |> Enum.map(fn vuelo ->
    precio_final = vuelo.precio * 0.9
    {vuelo.codigo, "#{vuelo.origen}-#{vuelo.destino}", precio_final}
  end)
  |> Enum.sort_by(fn {_, _, precio} -> precio end)

IO.inspect(resultado4)

resultado5 =
  vuelos
  |> Enum.group_by(& &1.aerolinea)
  |> Enum.filter(fn {_, lista_vuelos} ->
    categorias =
      Enum.map(lista_vuelos, fn vuelo ->
        cond do
          vuelo.duracion < 60 -> :corto
          vuelo.duracion <= 120 -> :medio
          true -> :largo
        end
      end)

    Enum.member?(categorias, :corto) and
      Enum.member?(categorias, :medio) and
      Enum.member?(categorias, :largo)
  end)
  |> Enum.map(fn {aerolinea, _} -> aerolinea end)

IO.inspect(resultado5)

resultado6 =
  vuelos
  |> Enum.filter(& &1.disponible)
  |> Enum.map(fn v ->
    {"#{v.origen} → #{v.destino}", v.precio * v.pasajeros}
  end)
  |> Enum.group_by(fn {ruta, _} -> ruta end)
  |> Enum.map(fn {ruta, lista} ->
    {ruta, Enum.reduce(lista, 0, fn {_, ingreso}, acc -> acc + ingreso end)}
  end)
  |> Enum.sort_by(fn {_, ingreso} -> -ingreso end)
  |> Enum.take(3)

IO.inspect(resultado6)
