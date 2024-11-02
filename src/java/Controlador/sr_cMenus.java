/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


/**
 *
 * @author DELL
 */
@WebServlet(name = "sr_cMenus", urlPatterns = {"/sr_cMenus"})
public class sr_cMenus extends HttpServlet {

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
        // Obtener el parámetro del menú desde la solicitud
        String menu = request.getParameter("menu");

        // Comprobar que el parámetro no sea nulo o vacío
        if (menu != null && !menu.isEmpty()) {
            // Redirigir en función del valor del parámetro 'menu'
            switch (menu) {
                case "Inventario":
                    request.getRequestDispatcher("Inventario.jsp").forward(request, response);
                    break;
                case "Marcas":
                    request.getRequestDispatcher("Marcas.jsp").forward(request, response);
                    break;
                case "Venta Nueva":
                    request.getRequestDispatcher("Registro_venta.jsp").forward(request, response);
                    break;
                case "Clientes":
                    request.getRequestDispatcher("Cliente.jsp").forward(request, response);
                    break;
                case "Empleados":
                    request.getRequestDispatcher("Empleado.jsp").forward(request, response);
                    break;
                case "Puestos":
                    request.getRequestDispatcher("Puesto.jsp").forward(request, response);
                    break;
                case "Proveedores":
                    request.getRequestDispatcher("Registro_proveedor.jsp").forward(request, response);
                    break;
                case "Compra Nueva":
                    request.getRequestDispatcher("Registro_compras.jsp").forward(request, response);
                    break;
                case "Reportes":
                    request.getRequestDispatcher("").forward(request, response);
                    break;
                default:
                    // Establece el mensaje de error cuando la opción no es válida
                    request.setAttribute("errorMensaje", "La opción seleccionada no es válida. Por favor, elige otra.");
                    break;
            }
        } else {
            // Si el parámetro 'menu' es nulo o vacío, mostrar mensaje de error y retornar a Principal.jsp
            request.setAttribute("errorMensaje", "No se seleccionó ninguna opción. Por favor, intenta de nuevo.");
            request.getRequestDispatcher("Principal.jsp").forward(request, response);
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
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet principal para manejar el menú dinámico";
    }

}
