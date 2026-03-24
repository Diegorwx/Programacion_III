defmodule Suma do
  def main do
    lista = [1, 2, 3, 5, 7, 11, 13, 17, 19]
    resultado = suma_lista(lista)
    IO.puts("suma_lista(#{inspect(lista)}) = #{resultado}")
  end

  def suma_lista([]), do: 0
  def suma_lista([x]), do: x

  def suma_lista(lista) do
    mitad = div(length(lista), 2)
    {izq, der} = Enum.split(lista, mitad)
    suma_lista(izq) + suma_lista(der)
  end
end

Suma.main()
