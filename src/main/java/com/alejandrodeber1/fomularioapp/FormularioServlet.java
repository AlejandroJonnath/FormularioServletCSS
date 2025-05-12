
package com.alejandrodeber1.fomularioapp;

// Importaciones necesarias para el funcionamiento del Servlet
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

// Anotación que define la URL de acceso al Servlet
@WebServlet("/registro")
public class FormularioServlet extends HttpServlet {

    // Método que procesa las solicitudes POST (envíos de formulario)
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Configurar codificación para caracteres especiales
        req.setCharacterEncoding("UTF-8");

        // Map para almacenar errores de validación. Usamos LinkedHashMap para mantener el orden de inserción
        Map<String,String> errores = new LinkedHashMap<>();

        // Obtención de parámetros del formulario
        // ----------------------------------------
        String username = req.getParameter("username");  // Campo de texto
        String password = req.getParameter("password"); // Contraseña
        String email    = req.getParameter("email");    // Email
        String pais     = req.getParameter("pais");     // Select (dropdown)
        String lenguaje = req.getParameter("lenguajes");// Radio buttons
        String[] roles  = req.getParameterValues("roles");// Checkboxes (múltiples valores)
        String idioma   = req.getParameter("idioma");   // Select múltiple
        String habil    = req.getParameter("habilitar");// Checkbox (valor único)
        String secreto  = req.getParameter("secreto");  // Campo oculto

        // Validación de campos obligatorios
        // ---------------------------------
        if (username == null || username.trim().isEmpty()) {
            errores.put("username", "El usuario es obligatorio.");
        }
        if (password == null || password.trim().isEmpty()) {
            errores.put("password", "La contraseña es obligatoria.");
        }
        if (email == null || email.trim().isEmpty()) {
            errores.put("email", "El email es obligatorio.");
        }
        if (pais == null || pais.trim().isEmpty()) {
            errores.put("pais", "Debe seleccionar un país.");
        }
        if (lenguaje == null || lenguaje.trim().isEmpty()) {
            errores.put("lenguajes", "Debe seleccionar un lenguaje.");
        }
        if (roles == null || roles.length == 0) {
            errores.put("roles", "Debe asignar al menos un rol.");
        }
        if (idioma == null || idioma.trim().isEmpty()) {
            errores.put("idioma", "Debe seleccionar un idioma.");
        }
        // Nota: 'habilitar' y 'secreto' no se validan:
        // - 'habilitar' es un checkbox opcional
        // - 'secreto' es un campo oculto que siempre debería llegar

        // Manejo de errores
        // ------------------
        if (!errores.isEmpty()) {
            // Agregamos los errores al request para mostrarlos en el JSP
            req.setAttribute("errores", errores);
            // Reenviamos al formulario manteniendo el request original
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
            return; // Importante salir del método después del forward
        }

        // Si no hay errores: Mostrar página de confirmación
        // --------------------------------------------------
        resp.setContentType("text/html;charset=UTF-8"); // Configurar tipo de contenido y codificación

        // Usamos try-with-resources para asegurar el cierre del PrintWriter
        try (PrintWriter out = resp.getWriter()) {
            // Generamos HTML dinámicamente
            out.println("<!DOCTYPE html><html lang='es'><head>");
            out.println("<meta charset='UTF-8'/><title>Confirmación</title>");
            out.println("</head><body>");
            out.println("<h2>¡Registro exitoso!</h2>");

            // Mostramos los valores recibidos:
            out.printf("<p><strong>Usuario:</strong> %s</p>%n", username);
            out.printf("<p><strong>Email:</strong> %s</p>%n", email);
            out.printf("<p><strong>País:</strong> %s</p>%n", pais);
            out.printf("<p><strong>Lenguaje:</strong> %s</p>%n", lenguaje);

            // Para roles (array) usamos String.join para unir elementos
            out.printf("<p><strong>Roles:</strong> %s</p>%n", String.join(", ", roles));
            out.printf("<p><strong>Idioma:</strong> %s</p>%n", idioma);

            // Checkbox: si existe el parámetro, muestra "Sí", sino "No"
            out.printf("<p><strong>Habilitado:</strong> %s</p>%n",
                    (habil != null) ? "Sí" : "No");

            out.println("</body></html>");
        }
    }

    // Método para manejar solicitudes GET (acceso directo a la URL)
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Redireccionamos a la página del formulario
        // Usamos sendRedirect para cambio de URL en el cliente
        resp.sendRedirect(req.getContextPath() + "/index.jsp");
    }
}