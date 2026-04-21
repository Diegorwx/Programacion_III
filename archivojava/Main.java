import java.io.*;

public class Main {
    public static void main(String[] args) {

        System.out.println("Ruta: " + new File("archivo.txt").getAbsolutePath());

        // ESCRIBIR
        try (BufferedWriter writer = new BufferedWriter(new FileWriter("archivo.txt"))) {
            writer.write("Aprendiendo a escribir en un archivo");
            writer.newLine();
            writer.write("Con BufferedWriter y FileReader es facil");
        } catch (IOException e) {
            e.printStackTrace();
        }

        // LEER
        try (BufferedReader reader = new BufferedReader(new FileReader("archivo.txt"))) {
            String linea;
            while ((linea = reader.readLine()) != null) {
                System.out.println(linea);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}