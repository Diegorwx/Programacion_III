import java.util.concurrent.Semaphore;

public class Semaforo{

    private static final Semaphore semaforo = new Semaphore(3);

    public static void main(String[] args) throws InterruptedException {
        // Lanzar 6 hilos que compiten por 3 permisos
        for (int i = 1; i <= 6; i++) {
            final int id = i;
            new Thread(() -> usarRecurso(id)).start();
        }
    }

    static void usarRecurso(int id) {
        System.out.println("T-" + id + " -> quiere el recurso");

        try {
            semaforo.acquire();       
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            return;
        }

        // Sección crítica — máximo 3 hilos simultáneos aquí
        try {
            System.out.println("T-" + id + " -> DENTRO (tickets: "
                    + semaforo.availablePermits() + " libres)");
            Thread.sleep(1500);          // Simula trabajo
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        } finally {
            semaforo.release();          // Devuelve el ticket 
            System.out.println("T-" + id + " -> salio, ticket devuelto");
        }
    }
}