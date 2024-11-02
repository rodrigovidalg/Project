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
import Modelo.Cliente;

/**
 *
 * @author DELL
 */
@WebServlet(name = "sr_cCliente", urlPatterns = {"/sr_cCliente"})
public class sr_cCliente extends HttpServlet {

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
        String action = request.getParameter("action");

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
        boolean genero = "M".equalsIgnoreCase(generoStr);
        String telefono = request.getParameter("txt_telefono");
        String correo = request.getParameter("txt_correo");
        String fechaIngreso = request.getParameter("txt_fi");

        // Validar que los campos requeridos no estén vacíos
        if (nombres == null || nombres.isEmpty() ||
            apellidos == null || apellidos.isEmpty() ||
            nit == null || nit.isEmpty() ||
            telefono == null || telefono.isEmpty() ||
            correo == null || correo.isEmpty() ||
            fechaIngreso == null || fechaIngreso.isEmpty()) {

            request.setAttribute("errorMessage", "Todos los campos son obligatorios."); // Mensaje de error
            request.getRequestDispatcher("Cliente.jsp").forward(request, response); // Mantener la vista
            return;
        }

        // Crear instancia de Cliente con los datos del formulario
        Cliente cliente = new Cliente(id, nombres, apellidos, nit, genero, telefono, correo, fechaIngreso);

        // Validar la acción (agregar, actualizar, eliminar)
        switch (action) { 
            case "agregar":
                if (cliente.agregar() > 0) {
                    request.setAttribute("successMessage", "Cliente agregado correctamente."); // Mensaje de éxito
                } else {
                    request.setAttribute("errorMessage", "Error al agregar cliente.");
                }
                break;

            case "actualizar":
                if (cliente.actualizar() > 0) {
                    request.setAttribute("successMessage", "Cliente actualizado correctamente."); // Mensaje de éxito
                } else {
                    request.setAttribute("errorMessage", "Error al actualizar cliente.");
                }
                break;

            case "eliminar":
                if (cliente.eliminar() > 0) {
                    request.setAttribute("successMessage", "Cliente eliminado correctamente."); // Mensaje de éxito
                } else {
                    request.setAttribute("errorMessage", "Error al eliminar cliente.");
                }
                break;

            default:
                request.setAttribute("errorMessage", "Acción no válida.");
                break;
        }

        // Redirigir a la página de cliente después de procesar la acción
        request.getRequestDispatcher("Cliente.jsp").forward(request, response);
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
