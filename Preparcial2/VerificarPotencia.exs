defmodule VerificarPotencia do

  def main do
    n = "Ingrese un número:"
    |> Util.ingresar(:entero)
    b = "Ingrese otro número:"
    |> Util.ingresar(:entero)

    resultado = verificar_potencia(n, b)
    IO.puts("El resultado es: #{resultado}")

  end

  def verificar_potencia(n, b) do
    cond do
      n == 1 -> true
      n < 1 or b <= 1 -> false
      rem(n, b) != 0 -> false
      true -> verificar_potencia(div(n, b), b)

    end
  end

end

VerificarPotencia.main()
