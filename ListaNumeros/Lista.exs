defmodule ListaNum do

  def main do
    lista = [1,2,3,5,7,11,13,17,19,23]
    imprimir(lista)
  end

  def imprimir([]), do: :ok

  def imprimir([hd | tl]) do
    IO.puts(hd)
    imprimir(tl)
  end
end

ListaNum.main()
