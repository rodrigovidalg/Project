package Controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Modelo.Cliente;

@WebServlet(urlPatterns = {"/sr_cCliente"})
public class sr_cCliente extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String menu = request.getParameter("menu");
        String action = request.getParameter("action");

        if ("Cliente".equals(menu)) {
            // Obtener los parámetros del formulario
            String idStr = request.getParameter("txt_id");
            int id = 0; // Valor por defecto
            if (idStr != null && !idStr.isEmpty()) {
                try {
                    id = Integer.parseInt(idStr);
                } catch (NumberFormatException e) {
                    response.sendRedirect("Cliente.jsp"); // Redirigir en caso de error
                    return;
                }
            }

            String nombres = request.getParameter("txt_nombres");
            String apellidos = request.getParameter("txt_apellidos");
            String nit = request.getParameter("txt_nit");
            String generoStr = request.getParameter("txt_genero");
            boolean genero = "true".equalsIgnoreCase(generoStr); // true para Masculino, false para Femenino
            String telefono = request.getParameter("txt_telefono");
            String correo = request.getParameter("txt_correo");
            String fechaIngreso = request.getParameter("txt_fi");

            // Validar que los campos requeridos no estén vacíos
            if (nombres == null || nombres.isEmpty() || apellidos == null || apellidos.isEmpty() ||
                nit == null || nit.isEmpty() || telefono == null || telefono.isEmpty() ||
                correo == null || correo.isEmpty() || fechaIngreso == null || fechaIngreso.isEmpty()) {
                
                request.getRequestDispatcher("Cliente.jsp").forward(request, response); // Mantener la vista si faltan datos
                return;
            }

            // Crear instancia de Cliente con los datos del formulario
            Cliente cliente = new Cliente(id, nombres, apellidos, nit, genero, telefono, correo, fechaIngreso);

            // Validar la acción (agregar, actualizar, eliminar)
            switch (action) { 
                case "agregar":
                    if (cliente.agregar() > 0) {
                        response.sendRedirect("Cliente.jsp");
                    } else {
                        response.getWriter().println("<h1>Error al agregar cliente</h1>");
                    }
                    return;

                case "actualizarE":
                    if (cliente.actualizar() > 0) {
                        response.sendRedirect("Cliente.jsp");
                    } else {
                        response.getWriter().println("<h1>Error al actualizar cliente</h1>");
                    }
                    return;

                case "eliminar":
                    if (cliente.eliminar() > 0) {
                        response.sendRedirect("Cliente.jsp");
                    } else {
                        response.getWriter().println("<h1>Error al eliminar cliente</h1>");
                    }
                    return;

                default:
                    response.getWriter().println("<h1>Acción no válida</h1>");
                    return;
            }
        } else {
            // Si el menú no es "Cliente", redirigir a la página principal o a un error
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
