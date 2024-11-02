/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import Modelo.Producto;
import java.sql.Date;
import Modelo.Ventas;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;

/**
 *
 * @author Christian
 */
public class sr_cVenta extends HttpServlet {

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
            out.println("<title>Servlet sr_cVenta</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet sr_cVenta at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action"); // Se espera un parámetro de acción
        Ventas ventas = new Ventas(); // Mover la creación de objeto Ventas aquí

        if ("eliminar".equals(action)) {
            String id_ventaStr = request.getParameter("txt_id_venta"); // ID de la venta a eliminar
            if (id_ventaStr != null && !id_ventaStr.isEmpty()) {
                int id_venta = Integer.parseInt(id_ventaStr);
                boolean eliminado = ventas.eliminar(id_venta);

                // Preparar la respuesta
                if (eliminado) {
                    response.sendRedirect("Registro_venta.jsp");
                } else {
                    // Mostrar mensaje de error
                    System.out.println("No se pudo eliminar la venta.");
                }
            }
        } else if ("actualizar".equals(action)) {
            // Lógica para modificar
            String id_ventaStr = request.getParameter("txt_id_venta");
            if (id_ventaStr != null && !id_ventaStr.isEmpty()) {
                int id_venta = Integer.parseInt(id_ventaStr);
                int no_factura = Integer.parseInt(request.getParameter("txt_no_factura"));
                String no_serie = request.getParameter("txt_no_serie");
                Date fecha_factura = Date.valueOf(request.getParameter("txt_fecha_factura"));
                int id_cliente = Integer.parseInt(request.getParameter("txt_id_cliente"));
                int id_empleado = Integer.parseInt(request.getParameter("txt_id_empleado"));
                Date fecha_ingreso = Date.valueOf(request.getParameter("txt_fecha_ingreso"));
                int id_producto = Integer.parseInt(request.getParameter("txt_id_producto"));
                int cantidad = Integer.parseInt(request.getParameter("txt_cantidad"));
                double precio_unitario = Double.parseDouble(request.getParameter("txt_precio_unitario"));

                // Llamar al método modificar
                int filasAfectadas = ventas.modificar(id_venta, no_factura, no_serie, fecha_factura, id_cliente, id_empleado, fecha_ingreso, id_producto, cantidad, precio_unitario);

                if (filasAfectadas > 0) {
                    response.sendRedirect("Registro_venta.jsp");
                } else {
                    System.out.println("No se pudo modificar la venta.");
                }
            }
        } else {
            // Lógica para agregar una nueva venta
            String no_facturaStr = request.getParameter("txt_no_factura");
            String no_serie = request.getParameter("txt_no_serie"); // Añadido no_serie
            String fecha_facturaStr = request.getParameter("txt_fecha_factura");
            String id_clienteStr = request.getParameter("txt_id_cliente");
            String id_empleadoStr = request.getParameter("txt_id_empleado");
            String fecha_ingresoStr = request.getParameter("txt_fecha_ingreso");
            String id_productoStr = request.getParameter("txt_id_producto");
            String cantidadStr = request.getParameter("txt_cantidad");
            String precio_unitarioStr = request.getParameter("txt_precio_unitario");

            // Conversión de las fechas a formato java.sql.Date
            Date fecha_factura = null;
            Date fecha_ingreso = null;

            try {
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                if (fecha_facturaStr != null && !fecha_facturaStr.isEmpty()) {
                    fecha_factura = new Date(format.parse(fecha_facturaStr).getTime());
                }
                if (fecha_ingresoStr != null && !fecha_ingresoStr.isEmpty()) {
                    fecha_ingreso = new Date(format.parse(fecha_ingresoStr).getTime());
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            // Convertir los demás parámetros a sus tipos correspondientes
            int no_factura = Integer.parseInt(no_facturaStr);
            int id_cliente = Integer.parseInt(id_clienteStr);
            int id_empleado = Integer.parseInt(id_empleadoStr);
            int id_producto = Integer.parseInt(id_productoStr);
            int cantidad = Integer.parseInt(cantidadStr);
            double precio_unitario = Double.parseDouble(precio_unitarioStr);

            // Crear objeto de Ventas y llamar a agregar
            int id_venta = ventas.agregar(no_factura, no_serie, fecha_factura, id_cliente, id_empleado, fecha_ingreso, id_producto, cantidad, precio_unitario);
            id_producto = Integer.parseInt(request.getParameter("txt_id_producto")); // Obtener el id_producto

            Producto producto = new Producto();
            boolean stockActualizado = producto.actualizarExistencia(id_producto, cantidad);
            
            // Preparar la respuesta
            if (id_venta > 0) {
            // En lugar de redirigir, añade un mensaje al request
                request.setAttribute("mensaje", "Venta agregada con éxito.");
            } else {
            request.setAttribute("mensaje", "Error al agregar la venta.");
            
            }
                request.getRequestDispatcher("Registro_venta.jsp").forward(request, response);

        }
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
