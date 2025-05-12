<%-- Directiva de página: Configuración de contenido y lenguaje --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%-- Importamos Map de Java --%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Arrays" %>
<%
    // Obtenemos el mapa de errores del request (con supresión de advertencia de cast)
    @SuppressWarnings("unchecked")
    Map<String, String> errores = (Map<String, String>) request.getAttribute("errores");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <%-- Configuración básica de la página --%>
    <meta charset="UTF-8">
    <title>Formulario de Usuario</title>
    <%-- Enlace a hoja de estilos usando context path para ruta absoluta --%>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Style.css" />
</head>
<body>
<h3>Formulario de Usuario</h3>

<%-- Bloque de errores: Se muestra solo si hay errores --%>
<% if (errores != null && !errores.isEmpty()) { %>
<div class="alert">
    <ul>
        <%-- Iteramos sobre los valores del mapa de errores --%>
        <% for (String err : errores.values()) { %>
        <li><%= err %></li> <%-- Mostramos cada mensaje de error --%>
        <% } %>
    </ul>
</div>
<% } %>

<%-- Formulario principal: Apunta al Servlet de registro --%>
<form action="<%= request.getContextPath() %>/registro" method="post">

    <%-- Campo Usuario --%>
    <div class="form-group">
        <label for="username">Usuario:</label>
        <%-- Mantenemos el valor ingresado después del envío --%>
        <input type="text" name="username" id="username"
               value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>" />
    </div>

    <%-- Campo Contraseña (no mantenemos valor por seguridad) --%>
    <div class="form-group">
        <label for="password">Password:</label>
        <input type="password" name="password" id="password" />
    </div>

    <%-- Campo Email con valor mantenido --%>
    <div class="form-group">
        <label for="email">Email:</label>
        <input type="email" name="email" id="email"
               value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>" />
    </div>

    <%-- Selector de País con opción pre-seleccionada --%>
    <div class="form-group">
        <label for="pais">País:</label>
        <select name="pais" id="pais">
            <option value="">----- Seleccionar -----</option>
            <%-- Cada opción verifica si fue seleccionada previamente --%>
            <option value="ES" <%= "ES".equals(request.getParameter("pais"))?"selected":"" %>>España</option>
            <option value="EC" <%= "EC".equals(request.getParameter("pais"))?"selected":"" %>>Ecuador</option>
        </select>
    </div>

    <%-- Selector de Lenguaje de Programación --%>
    <div class="form-group">
        <label for="lenguajes">Lenguajes:</label>
        <select name="lenguajes" id="lenguajes">
            <option value="">-- Seleccionar --</option>
            <%-- Mantiene selección previa usando operador ternario --%>
            <option value="Java" <%= "Java".equals(request.getParameter("lenguajes"))?"selected":"" %>>Java</option>
        </select>
    </div>

    <%-- Checkboxes de Roles (pueden ser múltiples selecciones) --%>
    <div class="form-group roles">
        <label>Roles:</label>
        <%-- Verificamos si el valor está en los parámetros enviados --%>
        <label><input type="checkbox" name="roles" value="ROLE_ADMIN"
                <%= (request.getParameterValues("roles")!=null &&
                        Arrays.asList(request.getParameterValues("roles")).contains("ROLE_ADMIN"))?"checked":"" %> /> Administrador</label>
        <%-- Misma lógica para otros roles --%>
    </div>

    <%-- Radio buttons para Idiomas --%>
    <div class="form-group idiomas">
        <label>Idiomas:</label>
        <%-- Radio buttons mantienen selección con operador ternario --%>
        <label><input type="radio" name="idioma" value="es" <%= "es".equals(request.getParameter("idioma"))?"checked":"" %> /> Español</label>
        <%-- ... otros idiomas ... --%>
    </div>

    <%-- Checkbox Habilitar --%>
    <div class="form-group">
        <label><input type="checkbox" name="habilitar" id="habilitar"
                <%= request.getParameter("habilitar")!=null?"checked":"" %> /> Habilitar</label>
    </div>

    <%-- Campo oculto para valor secreto --%>
    <input type="hidden" name="secreto" value="123456" />

    <%-- Botón de envío --%>
    <div class="form-group submit">
        <button type="submit">Enviar</button>
    </div>
</form>
</body>
</html>