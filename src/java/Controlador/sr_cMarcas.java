package Controlador;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import Modelo.Conexion;
import Modelo.Marca;

@WebServlet(name = "sr_cMarcas", urlPatterns = {"/sr_cMarcas"})
public class sr_cMarcas extends HttpServlet {

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

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        String menu = request.getParameter("menu");
        Conexion con = new Conexion();
        Connection cn = null;

        Marca marca = new Marca();

        try {
            con.abrir_conexion();

            if (menu != null && menu.equals("Marcas")) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("Marcas.jsp");
                dispatcher.forward(request, response);
                return;
            }

            if (action == null || action.isEmpty()) {
                throw new ServletException("Acción inválida");
            }

            switch (action) {
                case "agregar":
                    if (validateParameters(request, "marca")) {
                        marca.setMarca(request.getParameter("marca"));
                        marca.agregar();  // Se usa el método `agregar()` de la clase Marca
                        response.sendRedirect("Marcas.jsp");
                    } else {
                        throw new ServletException("Faltan parámetros para la acción de insertar marca");
                    }
                    break;
                case "actualizar":
                    if (validateParameters(request, "idMarca", "marca")) {
                        marca.setId(Integer.parseInt(request.getParameter("idMarca"))); // Asegúrate de que este ID se obtiene del campo oculto
                        marca.setMarca(request.getParameter("marca"));
                        marca.actualizar();  // Se usa el método `actualizar()` de la clase Marca
                        response.sendRedirect("Marcas.jsp");
                    } else {
                        throw new ServletException("Faltan parámetros para la acción de actualizar marca");
                    }
                    break;
                case "eliminar":
                    if (validateParameters(request, "idMarca")) {
                        marca.setId(Integer.parseInt(request.getParameter("idMarca"))); // Asegúrate de que este ID se obtiene del campo oculto
                        marca.eliminar();  // Se usa el método `eliminar()` de la clase Marca
                        response.sendRedirect("Marcas.jsp");
                    } else {
                        throw new ServletException("Faltan parámetros para la acción de eliminar marca");
                    }
                    break;
                default:
                    throw new ServletException("Acción no soportada");
            }
        } catch (NumberFormatException e) {
            throw new ServletException("Formato de número inválido: " + e.getMessage(), e);
        } finally {
            try {
                if (cn != null && !cn.isClosed()) {
                    con.cerrar_conexion();
                }
            } catch (SQLException ex) {
                throw new ServletException("Error cerrando conexión: " + ex.getMessage(), ex);
            }
        }
    }

    private boolean validateParameters(HttpServletRequest request, String... params) {
        for (String param : params) {
            if (request.getParameter(param) == null || request.getParameter(param).isEmpty()) {
                return false;
            }
        }
        return true;
    }

    @Override
    public String getServletInfo() {
        return "Controlador para gestionar las acciones de marcas";
    }
}
