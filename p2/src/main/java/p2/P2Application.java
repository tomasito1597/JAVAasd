package p2; // Asegúrate de que este paquete coincida con la estructura de carpetas

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

// 1. Marcar la clase como la aplicación principal
@SpringBootApplication 
// 2. Extender para compatibilidad con JSP/Servlets
public class P2Application extends SpringBootServletInitializer { 

	public static void main(String[] args) {
        // 3. Iniciar la aplicación, que también inicia el servidor Tomcat embebido
		SpringApplication.run(P2Application.class, args);
	}

    // Método necesario para construir el paquete JAR como una aplicación web
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(P2Application.class);
    }
}