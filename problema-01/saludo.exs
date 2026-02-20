# Versión 1
IO.puts("Bienvenidos a la empresa Once Ltda")

# Versión 2
"Bienvenidos a la empresa Once Ltda"
|> IO.puts()

# Versión 3
defmodule Saludo do
  def main do
    "Bienvenidos a la empresa Once Ltda"
    |> IO.puts()
  end
end

Saludo.main()

# Versión 4
defmodule Saludo do
  def main do
    "Bienvenidos a la empresa Once Ltda"
    |> IO.puts()
  end

  defp mostrar_mensaje(mensaje) do
    mensaje
    |> IO.puts()
  end
end

Saludo.main()

# Versión 5
defmodule Mensaje do
  def main do
    "Bienvenidos a la empresa Once Ltda"
    |> Util.mostrar_mensaje()
  end
end

Mensaje.main()

# Versión 6
defmodule Mensaje do
  def main do
    "Bienvenidos a la empresa Once Ltda"
    |> Util.mostrar_mensaje_java()
  end
end

Mensaje.main()
