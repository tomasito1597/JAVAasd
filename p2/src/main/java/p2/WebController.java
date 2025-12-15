package p2; // Usa tu paquete correcto

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WebController {

    @GetMapping("/")
    public String handleRootRequest() {
        // Esto apunta a 'probando.jsp'
        return "probando"; 
    }
}