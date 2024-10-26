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
import Modelo.Inventario;
import Modelo.Conexion;

@WebServlet(name = "sr_cInventario", urlPatterns = {"/sr_cInventario"})
public class sr_cInventario extends HttpServlet {

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
        con.abrir_conexion();
        Connection cn = con.getConnection();
        Inventario inventario = new Inventario();

        try {
            if (menu != null && menu.equals("Inventario")) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("Inventario.jsp");
                dispatcher.forward(request, response);
                return;
            }

            if (action == null || action.isEmpty()) {
                throw new ServletException("Accion invalida");
            }

            switch (action) {
                case "insert":
                    if (validateParameters(request, "producto", "descripcion", "precioCosto", "precioVenta", "existencia", "fechaIngreso")) {
                        inventario.setProducto(request.getParameter("producto"));
                        inventario.setDescripcion(request.getParameter("descripcion"));
                        inventario.setPrecioCosto(Double.parseDouble(request.getParameter("precioCosto")));
                        inventario.setPrecioVenta(Double.parseDouble(request.getParameter("precioVenta")));
                        inventario.setExistencia(Integer.parseInt(request.getParameter("existencia")));
                        inventario.setFechaIngreso(request.getParameter("fechaIngreso"));
                        inventario.agregar(cn);
                        response.sendRedirect("Inventario.jsp");
                    } else {
                        throw new ServletException("Missing parameters for insert action");
                    }
                    break;
                case "update":
                    if (validateParameters(request, "idProducto", "producto", "descripcion", "precioCosto", "precioVenta", "existencia", "fechaIngreso")) {
                        inventario.setIdProducto(Integer.parseInt(request.getParameter("idProducto")));
                        inventario.setProducto(request.getParameter("producto"));
                        inventario.setDescripcion(request.getParameter("descripcion"));
                        inventario.setPrecioCosto(Double.parseDouble(request.getParameter("precioCosto")));
                        inventario.setPrecioVenta(Double.parseDouble(request.getParameter("precioVenta")));
                        inventario.setExistencia(Integer.parseInt(request.getParameter("existencia")));
                        inventario.setFechaIngreso(request.getParameter("fechaIngreso"));
                        inventario.actualizar(cn);
                        response.sendRedirect("Inventario.jsp");
                    } else {
                        throw new ServletException("Missing parameters for update action");
                    }
                    break;
                case "delete":
                    if (validateParameters(request, "idProducto")) {
                        inventario.setIdProducto(Integer.parseInt(request.getParameter("idProducto")));
                        inventario.eliminar(cn);
                        response.sendRedirect("Inventario.jsp");
                    } else {
                        throw new ServletException("Missing parameters for delete action");
                    }
                    break;
                default:
                    throw new ServletException("Action not supported");
            }
        } catch (SQLException e) {
            throw new ServletException("SQL Error: " + e.getMessage(), e);
        } catch (NumberFormatException e) {
            throw new ServletException("Invalid number format: " + e.getMessage(), e);
        } finally {
            try {
                if (cn != null && !cn.isClosed()) {
                    con.cerrar_conexion();
                }
            } catch (SQLException ex) {
                throw new ServletException("Error closing connection: " + ex.getMessage(), ex);
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
        return "Short description";
    }
}
