/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Modelo.Empleado;
import Modelo.Puesto;
import Modelo.Usuario;

/**
 *
 * @author DELL
 */
public class sr_controlador extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String menu = request.getParameter("menu");
    String action = request.getParameter("action");

    switch (menu) {
        case "Principal":
            request.getRequestDispatcher("Principal.jsp").forward(request, response);
            break;

        case "Empleado":
            // Obtener los parámetros del formulario
            String idStr = request.getParameter("txt_id");
            int id = 0; // Valor por defecto
            if (idStr != null && !idStr.isEmpty()) {
                try {
                    id = Integer.parseInt(idStr);
                } catch (NumberFormatException e) {
                    response.sendRedirect("Empleado.jsp"); // Redirigir en caso de error
                    return;
                }
            }

            String nombres = request.getParameter("txt_nombres");
            String apellidos = request.getParameter("txt_apellidos");
            String direccion = request.getParameter("txt_direccion");
            String telefono = request.getParameter("txt_telefono");
            String dpi = request.getParameter("txt_dpi");
            String generoStr = request.getParameter("txt_genero");
            boolean genero = "M".equalsIgnoreCase(generoStr); // Suponiendo 'M' para masculino y cualquier otra cosa como femenino.
            String fechaNacimiento = request.getParameter("txt_fn");

            // Validar y parsear el puesto seleccionado
            String puestoStr = request.getParameter("drop_puesto");
            int puestos = 0; // Valor por defecto
            if (puestoStr != null && !puestoStr.isEmpty()) {
                try {
                    puestos = Integer.parseInt(puestoStr);
                } catch (NumberFormatException e) {
                    response.sendRedirect("Empleado.jsp");
                    return;
                }
            }

            String fechaInicioLabores = request.getParameter("txt_fl");
            String fechaIngreso = request.getParameter("txt_fi");

            // Validar que los campos requeridos no estén vacíos
            if (nombres == null || nombres.isEmpty() || apellidos == null || apellidos.isEmpty() ||
                direccion == null || direccion.isEmpty() || telefono == null || telefono.isEmpty() ||
                dpi == null || dpi.isEmpty() || fechaNacimiento == null || fechaNacimiento.isEmpty() ||
                puestos == 0 || fechaInicioLabores == null || fechaInicioLabores.isEmpty() || 
                fechaIngreso == null || fechaIngreso.isEmpty()) {
                
                request.getRequestDispatcher("Empleado.jsp").forward(request, response); // Mantener la vista
                return;
            }

            // Crear instancia de Empleado con los datos del formulario
            Empleado empleado = new Empleado(id, nombres, apellidos, direccion, telefono, dpi, genero, fechaNacimiento, puestos, fechaInicioLabores, fechaIngreso);

            // Validar la acción (agregar, actualizar, eliminar)
            switch (action) { 
                case "agregarE":
                    if (empleado.agregar() > 0) {
                        response.sendRedirect("Empleado.jsp");
                    } else {
                        response.getWriter().println("<h1>Error al agregar empleado</h1>");
                    }
                    break;

                case "actualizarE":
                    if (empleado.actualizar() > 0) {
                        response.sendRedirect("Empleado.jsp");
                    } else {
                        response.getWriter().println("<h1>Error al actualizar empleado</h1>");
                    }
                    break;

                case "eliminarE":
                    if (empleado.eliminar() > 0) {
                        response.sendRedirect("Empleado.jsp");
                    } else {
                        response.getWriter().println("<h1>Error al eliminar empleado</h1>");
                    }
                    break;

                default:
                    response.getWriter().println("<h1>Acción no válida</h1>");
                    break;
            }
            break;
            
        case "Puesto":
            // Obtener los parámetros del formulario
            String idPuestoStr = request.getParameter("txt_id_puesto");
            int id_Puesto = 0; // Valor por defecto
            if (idPuestoStr != null && !idPuestoStr.isEmpty()) {
                try {
                    id_Puesto = Integer.parseInt(idPuestoStr);
                } catch (NumberFormatException e) {
                    // Si hay error en el formato del ID, redirige a la página con un mensaje de error
                    request.setAttribute("error", "El ID del puesto no es válido.");
                    request.getRequestDispatcher("Empleado.jsp").forward(request, response);
                    return;
                }
            }

            String nombre_puesto = request.getParameter("txt_nombre_puesto");

            // Validar que los campos requeridos no estén vacíos
            if (nombre_puesto == null || nombre_puesto.isEmpty()) {
                request.setAttribute("error", "El nombre del puesto es obligatorio.");
                request.getRequestDispatcher("Empleado.jsp").forward(request, response); // Mantener la vista
                return;
            }

            // Crear instancia de Puesto con los datos del formulario
            Puesto puesto = new Puesto(id_Puesto, nombre_puesto);

            // Validar la acción (agregar, actualizar, eliminar)
                switch (action) {
                    case "agregarP":
                        try {
                            puesto.agregar();
                            response.sendRedirect("Empleado.jsp");
                        } catch (Exception e) {
                            request.setAttribute("error", "Error al agregar el puesto.");
                            request.getRequestDispatcher("Empleado.jsp").forward(request, response);
                        }
                        break;

                    case "actualizarP":
                        try {
                            puesto.actualizar();
                            response.sendRedirect("Empleado.jsp");
                        } catch (Exception e) {
                            request.setAttribute("error", "Error al actualizar el puesto.");
                            request.getRequestDispatcher("Empleado.jsp").forward(request, response);
                        }
                        break;

                    case "eliminarP":
                        try {
                            puesto.setId_Puesto(id_Puesto); // Asegúrate de establecer el ID antes de eliminar
                            puesto.eliminarPuesto();
                            response.sendRedirect("Empleado.jsp");
                        } catch (Exception e) {
                            request.setAttribute("error", "Error al eliminar el puesto.");
                            request.getRequestDispatcher("Empleado.jsp").forward(request, response);
                        }
                        break;

                    default:
                        response.getWriter().println("<h1>Acción no válida</h1>");
                        break;
                }
            break;
        
        case "Usuario":
            // Obtener los parámetros del formulario
            String idUsuarioStr = request.getParameter("txt_id_usuario");
            int idUsuario = 0; // Valor por defecto
            if (idUsuarioStr != null && !idUsuarioStr.isEmpty()) {
                try {
                    idUsuario = Integer.parseInt(idUsuarioStr);
                } catch (NumberFormatException e) {
                    response.sendRedirect("Empleado.jsp"); // Redirigir en caso de error
                    return;
                }
            }

            String user = request.getParameter("txt_nombre_usuario");
            String pass = request.getParameter("txt_contraseña");
            String rol = request.getParameter("drop_puestoU");


            // Validar que los campos requeridos no estén vacíos
            if (user == null || user.isEmpty() || pass == null || pass.isEmpty() || rol == null || rol.isEmpty()) {
                request.setAttribute("error", "Todos los campos son obligatorios.");
                request.getRequestDispatcher("Empleado.jsp").forward(request, response); // Mantener la vista
                return;
            }

            // Crear instancia de Usuario con los datos del formulario
            Usuario usuario = new Usuario(idUsuario, user, pass, rol);

            // Validar la acción (agregar, actualizar, eliminar)
            switch (action) { 
                case "agregarU":
                    if (usuario.agregar() > 0) {
                        response.sendRedirect("Empleado.jsp");
                    } else {
                        response.getWriter().println("<h1>Error al agregar empleado</h1>");
                    }
                    break;

                case "actualizarU":
                    if (usuario.actualizar() > 0) {
                        response.sendRedirect("Empleado.jsp");
                    } else {
                        response.getWriter().println("<h1>Error al actualizar empleado</h1>");
                    }
                    break;

                case "eliminarU":
                    if (usuario.eliminar() > 0) {
                        response.sendRedirect("Empleado.jsp");
                    } else {
                        response.getWriter().println("<h1>Error al eliminar empleado</h1>");
                    }
                    break;

                default:
                    response.getWriter().println("<h1>Acción no válida</h1>");
                    break;
            }
            break;




        case "Cliente":
            request.getRequestDispatcher("Cliente.jsp").forward(request, response);
            break;

        case "Producto":
            request.getRequestDispatcher("Producto.jsp").forward(request, response);
            break;

        case "Nueva_compra":
            request.getRequestDispatcher("Registro_compra.jsp").forward(request, response);
            break;

        case "Nueva_venta":
            request.getRequestDispatcher("Registro_venta.jsp").forward(request, response);
            break;

        default:
            response.getWriter().println("<h1>Menú no válido</h1>");
            response.getWriter().println("<a href='Principal.jsp'>Regresar</a>");
            break;
    }
}


    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
