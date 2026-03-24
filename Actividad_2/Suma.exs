defmodule Suma do

  def main do

    resultado = sumar(5)
    IO.puts("sumar(5) = #{resultado}")

  end

  defp sumar(0) do
    0
  end

  defp sumar(n) do
    n + sumar(n - 1)
  end

end

Suma.main()
