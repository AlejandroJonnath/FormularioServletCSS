<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%-- Página JSP que define el tipo de contenido y el lenguaje --%>
<%@ page import="java.util.Map" %>
<%-- Importa la clase Map para manejar errores --%>
<%
    @SuppressWarnings("unchecked")
    Map<String, String> errores = (Map<String, String>) request.getAttribute("errores");
%>
<%-- Obtiene el mapa de errores desde el request y suprime advertencias de tipo --%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <!-- Define la codificación de caracteres -->
    <title>Formulario de Usuario</title>
    <!-- Título de la página mostrado en la pestaña del navegador -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Style.css" />
    <!-- Enlaza la hoja de estilos CSS con ruta dinámica según el contexto de la aplicación -->
</head>
<body>
<h3>Formulario de Usuario</h3>
<!-- Encabezado principal del formulario -->

<% if (errores != null && !errores.isEmpty()) { %>
<!-- Comprueba si existen errores para mostrarlos -->
<div class="alert">
    <ul>
        <% for (String err : errores.values()) { %>
        <!-- Itera sobre los mensajes de error y los lista -->
        <li><%= err %></li>
        <% } %>
    </ul>
</div>
<% } %>

<form action="<%= request.getContextPath() %>/registro" method="post">
    <!-- Formulario que envía datos via POST a la ruta /registro -->
    <div class="form-group">
        <label for="username">Usuario:</label>
        <!-- Etiqueta asociada al campo de usuario -->
        <input type="text" name="username" id="username"
               value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>" />
        <!-- Campo de texto para nombre de usuario, conserva valor previo en caso de error -->
    </div>

    <div class="form-group">
        <label for="password">Password:</label>
        <!-- Etiqueta para contraseña -->
        <input type="password" name="password" id="password" />
        <!-- Campo de contraseña, no conserva valor por seguridad -->
    </div>

    <div class="form-group">
        <label for="email">Email:</label>
        <!-- Etiqueta para email -->
        <input type="email" name="email" id="email"
               value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>" />
        <!-- Campo de email, conserva valor previo en caso de error -->
    </div>

    <div class="form-group">
        <label for="pais">País:</label>
        <!-- Etiqueta para selección de país -->
        <select name="pais" id="pais">
            <option value="">----- Seleccionar -----</option>
            <!-- Opción por defecto sin valor -->
            <option value="ES" <%= "ES".equals(request.getParameter("pais"))?"selected":"" %>>España</option>
            <!-- Opción España, seleccionada si coincide con el parámetro -->
            <option value="EC" <%= "EC".equals(request.getParameter("pais"))?"selected":"" %>>Ecuador</option>
            <option value="PE" <%= "PE".equals(request.getParameter("pais"))?"selected":"" %>>Perú</option>
            <option value="CO" <%= "CO".equals(request.getParameter("pais"))?"selected":"" %>>Colombia</option>
            <option value="BR" <%= "BR".equals(request.getParameter("pais"))?"selected":"" %>>Brasil</option>
            <option value="AR" <%= "AR".equals(request.getParameter("pais"))?"selected":"" %>>Argentina</option>
            <option value="VE" <%= "VE".equals(request.getParameter("pais"))?"selected":"" %>>Venezuela</option>
            <!-- Más países según opciones disponibles -->
        </select>
    </div>

    <div class="form-group">
        <label for="lenguajes">Lenguajes:</label>
        <!-- Etiqueta para selección de lenguaje de programación -->
        <select name="lenguajes" id="lenguajes">
            <option value="">-- Seleccionar --</option>
            <!-- Opción por defecto -->
            <option value="Java" <%= "Java".equals(request.getParameter("lenguajes"))?"selected":"" %>>Java</option>
            <option value="Python" <%= "Python".equals(request.getParameter("lenguajes"))?"selected":"" %>>Python</option>
            <option value="C#" <%= "C#".equals(request.getParameter("lenguajes"))?"selected":"" %>>C#</option>
            <option value="C++" <%= "C++".equals(request.getParameter("lenguajes"))?"selected":"" %>>C++</option>
            <option value="Angular" <%= "Angular".equals(request.getParameter("lenguajes"))?"selected":"" %>>Angular</option>
        </select>
    </div>

    <div class="form-group roles">
        <label>Roles:</label>
        <!-- Grupo de checkbox para asignar roles al usuario -->
        <label><input type="checkbox" name="roles" value="ROLE_ADMIN"
                <%= (request.getParameterValues("roles")!=null && java.util.Arrays.asList(request.getParameterValues("roles")).contains("ROLE_ADMIN"))?"checked":"" %> /> Administrador</label>
        <label><input type="checkbox" name="roles" value="ROLE_USER"
                <%= (request.getParameterValues("roles")!=null && java.util.Arrays.asList(request.getParameterValues("roles")).contains("ROLE_USER"))?"checked":"" %> /> Usuario</label>
        <label><input type="checkbox" name="roles" value="ROLE_MODERADOR"
                <%= (request.getParameterValues("roles")!=null && java.util.Arrays.asList(request.getParameterValues("roles")).contains("ROLE_MODERADOR"))?"checked":"" %> /> Moderador</label>
    </div>

    <div class="form-group idiomas">
        <label>Idiomas:</label>
        <!-- Grupo de radio buttons para elegir idioma -->
        <label><input type="radio" name="idioma" value="es" <%= "es".equals(request.getParameter("idioma"))?"checked":"" %> /> Español</label>
        <label><input type="radio" name="idioma" value="en" <%= "en".equals(request.getParameter("idioma"))?"checked":"" %> /> Inglés</label>
        <label><input type="radio" name="idioma" value="ru" <%= "ru".equals(request.getParameter("idioma"))?"checked":"" %> /> Ruso</label>
    </div>

    <div class="form-group">
        <label><input type="checkbox" name="habilitar" id="habilitar"
                <%= request.getParameter("habilitar")!=null?"checked":"" %> /> Habilitar</label>
        <!-- Checkbox para habilitar funcionalidad adicional -->
    </div>

    <input type="hidden" name="secreto" value="123456" />
    <!-- Campo oculto con valor secreto para procesar en el servidor -->

    <div class="form-group submit">
        <button type="submit">Enviar</button>
        <!-- Botón para enviar el formulario -->
    </div>
</form>
</body>
</html>
