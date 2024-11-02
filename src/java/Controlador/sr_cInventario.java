/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import Modelo.Producto;

/**
 * Servlet implementation for handling product inventory, including image upload.
 */
@WebServlet(name = "sr_cInventario", urlPatterns = {"/sr_cInventario"})
@MultipartConfig // Required for handling file uploads
public class sr_cInventario extends HttpServlet {
    
   // Path where product images will be saved on the server
    private static final String IMAGE_UPLOAD_PATH = "C:\\path\\to\\your\\uploads\\products\\";

    /**
     * Handles both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");

        switch (accion) {
            case "agregar":
                agregarProducto(request, response);
                break;
            case "actualizar":
                actualizarProducto(request, response);
                break;
            case "eliminar":
                eliminarProducto(request, response);
                break;
            default:
                response.sendRedirect("Inventario.jsp");
                return; // Exit if the action is invalid
        }

        response.sendRedirect("Inventario.jsp");
    }

    private void agregarProducto(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {
        Producto producto = crearProductoDesdeRequest(request);
        if (producto != null) {
            File imagenArchivo = obtenerImagenArchivo(request); // Get the image file
            int resultado = producto.agregar(imagenArchivo); // Call the add method from the Producto class
            if (resultado > 0) {
                System.out.println("Producto agregado exitosamente.");
            } else {
                System.out.println("Error al agregar el producto.");
            }
        }
    }

    private void actualizarProducto(HttpServletRequest request, HttpServletResponse response) 
        throws IOException, ServletException {
        String idStr = request.getParameter("idProducto");

        if (idStr == null || idStr.isEmpty()) {
            System.out.println("ID de producto no proporcionado o vacío.");
            return; // O redirige a una página de error
        }

        int id;
        try {
            id = Integer.parseInt(idStr); // Intenta convertir a entero
        } catch (NumberFormatException e) {
            System.out.println("Error al convertir ID de producto a número: " + e.getMessage());
            return; // O redirige a una página de error
        }

        Producto producto = crearProductoDesdeRequest(request);
        if (producto != null) {
            producto.setId(id); // Asigna el ID del producto
            File imagenArchivo = obtenerImagenArchivo(request); // Obtener la imagen
            int resultado = producto.actualizar(imagenArchivo); // Llama al método actualizar de la clase Producto
            if (resultado > 0) {
                System.out.println("Producto actualizado exitosamente.");
            } else {
                System.out.println("Error al actualizar el producto.");
            }
        } else {
            System.out.println("Producto no válido.");
        }
    }

    private void eliminarProducto(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("idProducto"));
        Producto producto = new Producto();
        producto.setId(id);
        int resultado = producto.eliminar(); // Call the delete method from the Producto class
        if (resultado > 0) {
            System.out.println("Producto eliminado exitosamente.");
        } else {
            System.out.println("Error al eliminar el producto.");
        }
    }

    private Producto crearProductoDesdeRequest(HttpServletRequest request) 
        throws IOException, ServletException {
        String productoNombre = request.getParameter("producto");

        // Verificar si el parámetro es nulo o vacío, y asignar valores predeterminados en su caso
        int idMarca = 0;
        if (request.getParameter("drop_marca") != null && !request.getParameter("drop_marca").isEmpty()) {
            idMarca = Integer.parseInt(request.getParameter("drop_marca"));
        }

        String descripcion = request.getParameter("descripcion");

        double precioCosto = 0.0;
        if (request.getParameter("precioCosto") != null && !request.getParameter("precioCosto").isEmpty()) {
            precioCosto = Double.parseDouble(request.getParameter("precioCosto"));
        }

        double precioVenta = 0.0;
        if (request.getParameter("precioVenta") != null && !request.getParameter("precioVenta").isEmpty()) {
            precioVenta = Double.parseDouble(request.getParameter("precioVenta"));
        }

        int existencia = 0;
        if (request.getParameter("existencia") != null && !request.getParameter("existencia").isEmpty()) {
            existencia = Integer.parseInt(request.getParameter("existencia"));
        }

        String fechaIngreso = request.getParameter("fechaIngreso");

        // Crear y configurar el objeto Producto
        Producto producto = new Producto();
        producto.setProducto(productoNombre);
        producto.setId_marca(idMarca);
        producto.setDescripcion(descripcion);
        producto.setPrecio_costo(precioCosto);
        producto.setPrecio_venta(precioVenta);
        producto.setExistencia(existencia);
        producto.setFecha_ingreso(fechaIngreso);

        return producto;
    }


    private File obtenerImagenArchivo(HttpServletRequest request) throws IOException, ServletException {
        Part filePart = request.getPart("imagen"); // Obtain the file
        if (filePart != null && filePart.getSize() > 0) {
            String imagenNombre = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName(); // Unique name
            File uploads = new File(IMAGE_UPLOAD_PATH);
            if (!uploads.exists()) {
                uploads.mkdirs(); // Create the directory if it does not exist
            }
            File file = new File(uploads, imagenNombre);
            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING); // Save the image
            }
            return file; // Return the saved file
        }
        return null; // No file uploaded
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
        return "Servlet that manages product inventory, including file upload.";
    }
}
