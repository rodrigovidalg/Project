<%-- 
    Document   : Principal
    Created on : 13/10/2024, 7:21:38 a. m.
    Author     : DELL
--%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="Modelo.Menu"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="Modelo.Empleado"%>
<%@page import="javax.servlet.http.HttpSession" %>

<%
    
    if (session == null || session.getAttribute("empleado") == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    Empleado empleado = (Empleado) session.getAttribute("empleado");
%>
<%
    response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Página Principal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"> <!-- Iconos de Bootstrap -->
    <style>
        .nav-link {
            color: white !important;
        }
        .dropdown-item {
            color: black !important;
        }
        .dropdown-item:hover {
            background-color: #f8f9fa;
            color: black !important;
        }
        .dropdown-submenu {
            position: relative;
        }
        .dropdown-submenu .dropdown-menu {
            left: 100%;
            top: 0;
            margin-top: 0;
        }
        .usuario-dropdown {
            margin-left: auto; /* Mueve el dropdown al extremo derecho */
        }
        .content-container {
            max-width: 1200px; /* Max ancho para centrar contenido */
            margin: 0 auto; /* Centra el contenedor */
            padding: 20px; /* Espaciado interno */
            border: 1px solid #094067; /* Borde del contenedor */
            background-color: white; /* Fondo blanco */
            border-radius: 8px; /* Bordes redondeados */
        }
    </style>
</head>
<body style="background-color: #d8eefe;">
    <nav class="navbar navbar-expand-lg" style="background-color: #094067;">
        <div class="container-fluid">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <%
                        // Conexión a la base de datos y obtención de menús
                        List<Menu> menus = new ArrayList<>();
                        try {
                            Menu menu = new Menu();
                            menus = menu.obtenerMenus();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }

                        // Creación de estructura jerárquica
                        Map<Integer, List<Menu>> menuTree = new HashMap<>();
                        for (Menu item : menus) {
                            menuTree.computeIfAbsent(item.getRamaPadre(), k -> new ArrayList<>()).add(item);
                        }

                        // Renderización del menú principal
                        List<Menu> rootMenus = menuTree.getOrDefault(null, new ArrayList<>());
                        out.print("<ul class='navbar-nav'>");

                        for (Menu item : rootMenus) {
                            out.print("<li class='nav-item dropdown'>");
                            out.print("<a class='nav-link dropdown-toggle' href='#' role='button' data-bs-toggle='dropdown' aria-expanded='false'>" + item.getNombre() + "</a>");

                            // Verificar si hay submenús en primer nivel
                            List<Menu> subItems = menuTree.get(item.getId());
                            if (subItems != null && !subItems.isEmpty()) {
                                out.print("<ul class='dropdown-menu'>");
                                for (Menu subItem : subItems) {
                                    out.print("<li class='dropdown-submenu'>");
                                    out.print("<a class='dropdown-item dropdown-toggle' href='sr_cMenus?menu=" + subItem.getNombre() + "' target='frame'>" + subItem.getNombre() + "</a>");

                                    // Verificar si hay submenús de segundo nivel
                                    List<Menu> subSubItems = menuTree.get(subItem.getId());
                                    if (subSubItems != null && !subSubItems.isEmpty()) {
                                        out.print("<ul class='dropdown-menu'>");
                                        for (Menu subSubItem : subSubItems) {
                                            out.print("<li>");
                                            out.print("<a class='dropdown-item' href='sr_cMenus?menu=" + subSubItem.getNombre() + "' target='frame'>" + subSubItem.getNombre() + "</a>");
                                            out.print("</li>");
                                        }
                                        out.print("</ul>");
                                    }
                                    out.print("</li>");
                                }
                                out.print("</ul>");
                            }

                            out.print("</li>");
                        }

                        out.print("</ul>");
                    %>
                </ul>
                <!-- Sección del botón de usuario fuera de la lista de navegación -->
                <div class="dropdown usuario-dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false" style="background-color: #094067; border-color: #094067;">
                        <i class="bi bi-person" style="font-size: 30px;"></i> <!-- Icono de usuario -->
                    </button>
                    <ul class="dropdown-menu" style="background-color: #5f6c7b;">
                        <li><a class="dropdown-item" href="#" style="color: white;">${empleado.nombres}</a></li>
                        <li>
                            <a class="dropdown-item" href="Logout" style="color: white;">Salir</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>
    <div class="content-container mt-4">
        <div class="container" style="height: 530px;">
            <iframe name="frame" style="height: 100%; width: 100%; border: none"></iframe>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
