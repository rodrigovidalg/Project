/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import Modelo.Compras;
import Modelo.ComprasDAO;
import Modelo.DetalleCompra;
import Modelo.Proveedores;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.WebServlet;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "sr_cCompras", urlPatterns = {"/sr_cCompras"})
public class sr_cCompras extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String menu = request.getParameter("menu");

        if ("Nueva_compra".equals(menu)) {
            handleNuevaCompra(request, response);
        } else if ("Proveedores".equals(menu)) {
            handleProveedores(request, response);
        } else {
            response.sendRedirect("Registro_compra.jsp");
        }
    }

private void handleNuevaCompra(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	String action = request.getParameter("action");
	ComprasDAO comprasDAO = new ComprasDAO(); // Crear instancia de ComprasDAO
	// Obtener los parámetros de compra
	String idProveedorStr = request.getParameter("txt_id_proveedor");
	String fechaOrden = request.getParameter("txt_fecha_orden");
	String fechaIngreso = request.getParameter("txt_fecha_ingreso");
	String idCompraStr = request.getParameter("txt_id_compra"); // ID de compra
	// Validar que los campos requeridos no estén vacíos
	if(idProveedorStr == null || idProveedorStr.isEmpty() || fechaOrden == null || fechaOrden.isEmpty() || fechaIngreso == null || fechaIngreso.isEmpty() || (action.equals("actualizar") && (idCompraStr == null || idCompraStr.isEmpty()))) { // Validar idCompraStr solo si se actualiza
		request.getRequestDispatcher("Registro_compras.jsp").forward(request, response);
		return;
	}
	int idProveedor;
	int idCompra = -1; // Valor por defecto
	try {
		idProveedor = Integer.parseInt(idProveedorStr);
		Compras nuevaCompra;
		switch(action) {
			case "agregar":
				Compras comprasInstance = new Compras();
				int nuevoNumeroOrdenCompra = comprasInstance.obtenerUltimoNum() + 1;
				// Crear una nueva instancia de Compra
				nuevaCompra = new Compras(nuevoNumeroOrdenCompra, nuevoNumeroOrdenCompra, idProveedor, fechaOrden, fechaIngreso);
				// Aquí debes recoger los detalles (productos) que se van a agregar
				List < DetalleCompra > detalles = obtenerDetallesDesdeFormulario(request); // Método para obtener detalles
				// Agregar la compra y sus detalles
				comprasDAO.agregarCompraYDetalles(nuevaCompra, detalles); // Llama al nuevo método
				response.sendRedirect("Registro_compras.jsp");
				break;
			case "actualizar":
				idCompra = Integer.parseInt(idCompraStr); // Obtener el ID de compra para actualizar
				// Obtener la compra existente para obtener el no_orden_compra
				Compras compraExistente = comprasDAO.obtenerCompraPorId(idCompra); // Asegúrate de que este método exista
				if(compraExistente != null) {
					// Crear una nueva instancia de Compra con los datos actualizados
					nuevaCompra = new Compras(idCompra, compraExistente.getNo_orden_compra(), idProveedor, fechaOrden, fechaIngreso);
					// Aquí debes recoger los detalles actualizados desde el formulario
					List < DetalleCompra > detallesActualizados = obtenerDetallesDesdeFormulario(request); // Método para obtener detalles actualizados
					// Actualizar la compra y sus detalles
					comprasDAO.actualizarCompraYDetalles(nuevaCompra, detallesActualizados); // Llama al nuevo método
					response.sendRedirect("Registro_compras.jsp");
				} else {
					response.getWriter().println("<h1>No se encontró la compra</h1>");
					request.getRequestDispatcher("Registro_compras.jsp").forward(request, response);
				}
				break;
			case "eliminar":
				idCompra = Integer.parseInt(idCompraStr); // Obtener el ID de compra para eliminar
				if(comprasDAO.eliminarCompraYDetalles(idCompra)) { // Llama al nuevo método
					response.sendRedirect("Registro_compras.jsp");
				} else {
					response.getWriter().println("<h1>No se pudo eliminar la compra</h1>");
					request.getRequestDispatcher("Registro_compras.jsp").forward(request, response);
				}
				break;
			default:
				response.sendRedirect("Registro_compras.jsp");
				break;
		}
	} catch (NumberFormatException e) {
		response.sendRedirect("Registro_compras.jsp");
	}
}

    private void handleProveedores(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        // Validar y obtener el ID
        String idStr = request.getParameter("txt_id");
        int id = 0; // Valor por defecto
        if (idStr != null && !idStr.isEmpty()) {
            try {
                id = Integer.parseInt(idStr);
            } catch (NumberFormatException e) {
                response.sendRedirect("Registro_proveedor.jsp"); // Redirigir en caso de error
                return;
            }
        }

        String proveedor = request.getParameter("txt_proveedor");
        String nit = request.getParameter("txt_nit");
        String direccion = request.getParameter("txt_direccion");
        String telefono = request.getParameter("txt_telefono");

        // Validar que los campos requeridos no estén vacíos
        if (proveedor == null || proveedor.isEmpty() || nit == null || nit.isEmpty() ||
            direccion == null || direccion.isEmpty() || telefono == null || telefono.isEmpty()) {
            request.getRequestDispatcher("Registro_proveedor.jsp").forward(request, response); 
            return;
        }

        Proveedores proveedores = new Proveedores(id, proveedor, nit, direccion, telefono);

        switch (action) {
            case "agregar":
                if (proveedores.agregar() > 0) {
                    response.sendRedirect("Registro_proveedor.jsp");
                }
                break;

            case "actualizar":
                if (proveedores.actualizar() > 0) {
                    response.sendRedirect("Registro_proveedor.jsp");
                }
                break;

            case "eliminar":
                if (proveedores.eliminar() > 0) {
                    response.sendRedirect("Registro_proveedor.jsp");
                }
                break;

            default:
                response.sendRedirect("Registro_proveedor.jsp"); 
                break;
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

    private List<DetalleCompra> obtenerDetallesDesdeFormulario(HttpServletRequest request) {
    List<DetalleCompra> detalles = new ArrayList<>();
    
    String[] idsProductos = request.getParameterValues("id_producto[]"); // IDs de productos
    String[] cantidades = request.getParameterValues("cantidad[]"); 
    String[] preciosUnitarios = request.getParameterValues("precio_costo_unitario[]");

    if (idsProductos != null && cantidades != null && preciosUnitarios != null) {
        for (int i = 0; i < idsProductos.length; i++) {
            DetalleCompra detalle = new DetalleCompra();
            detalle.setId_producto(Integer.parseInt(idsProductos[i])); // Establecer ID del producto
            detalle.setCantidad(Integer.parseInt(cantidades[i])); // Establecer cantidad
            detalle.setPrecio_costo_unitario(Double.parseDouble(preciosUnitarios[i])); // Establecer precio unitario
            
            detalles.add(detalle); // Agregar a la lista
        }
    }
    
    return detalles; // Devolver la lista de detalles
}
}
