package p2; // Su paquete

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WebController {

    // Maneja la solicitud a la URL que index.html pide: /probando
    @GetMapping("/probando") // <--- Notar que la ruta es /probando
    public String handleProbandoRequest() {
        // Retorna el nombre del archivo JSP: probando.jsp
        return "probando"; 
    }
    
    // Opcional, pero seguro: manejar la raíz y redirigir
    @GetMapping("/")
    public String handleRootRequest() {
        return "redirect:/probando"; // Redirección directa si alguien llega a la raíz
    }
}
