/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Modelo.Empleado;
import Modelo.Usuario;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Christian
 */
public class sr_cIndex extends HttpServlet {
Empleado empleado = new Empleado();
Usuario usuario= new Usuario();
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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet sr_cIndex</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet sr_cIndex at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String user = request.getParameter("txt_user");
    String pass = request.getParameter("txt_pass");

    // 2. Validar el usuario
    empleado = usuario.validar(user, pass); // Retorna un objeto Empleado

    if (empleado != null) {
        // Crear una sesión y almacenar los datos del usuario
        HttpSession session = request.getSession();
        session.setAttribute("empleado", empleado);

        // Verificar el rol del usuario y redirigir según corresponda
        String rol = empleado.getRol();
        boolean accesoPermitido = false;

        switch (rol) {
            case "admin":
                accesoPermitido = true; // Admin tiene acceso a todo
                break;
            case "Ventas":
                accesoPermitido = request.getRequestURI().contains("Principal.jsp") || 
                                  request.getRequestURI().contains("Registro_venta.jsp");
                break;
            case "Compras":
                accesoPermitido = request.getRequestURI().contains("Principal.jsp") || 
                                  request.getRequestURI().contains("Registro_compra.jsp");
                break;
            case "Bodega":
                accesoPermitido = request.getRequestURI().contains("Principal.jsp") || 
                                  request.getRequestURI().contains("Producto.jsp");
                break;
            case "Clientes":
                accesoPermitido = request.getRequestURI().contains("Principal.jsp") || 
                                  request.getRequestURI().contains("Cliente.jsp");
                break;
            case "RRHH":
                accesoPermitido = request.getRequestURI().contains("Principal.jsp") || 
                                  request.getRequestURI().contains("Empleado.jsp");
                break;
            default:
                break;
        }

        if (accesoPermitido) {
            response.sendRedirect("Principal.jsp"); // Cambia la URL a Principal.jsp
        } else {
            // Si no tiene acceso, redirigir con un mensaje
            request.setAttribute("error", "No tiene acceso a esa sección.");
            response.sendRedirect("Principal.jsp"); // O podrías mostrar el error en un mensaje en Principal.jsp
        }
    } else {
        // Enviar mensaje de error y volver a index.jsp
        request.setAttribute("error", "Usuario o contraseña incorrectos");
        response.sendRedirect("index.jsp"); // Cambiar a sendRedirect aquí también
    }
    }


    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
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
