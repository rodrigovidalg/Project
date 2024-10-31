/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;
import Modelo.Compras;
import Modelo.DetalleCompra;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.swing.table.DefaultTableModel;
/**
 *
 * @author user
 */
public class ComprasDAO {
    Conexion cn;
    
    public ComprasDAO() {
        cn = new Conexion(); // Inicializa tu conexión aquí
        cn.abrir_conexion(); // Asegúrate de abrir la conexión
    }

    
public Compras obtenerCompraPorId(int idCompra) {
    Compras compra = null;
    try {
        String query = "SELECT * FROM compras WHERE id_compra = ?";
        PreparedStatement parametro = cn.conexionDB.prepareStatement(query);
        parametro.setInt(1, idCompra);
        ResultSet rs = parametro.executeQuery();

        if (rs.next()) {
            compra = new Compras(
                rs.getInt("id_compra"),
                rs.getInt("no_orden_compra"),
                rs.getInt("id_proveedor"),
                rs.getString("fecha_orden"),
                rs.getString("fecha_ingreso")
            );
        }
    } catch (SQLException ex) {
        System.out.println("Error al obtener la compra: " + ex.getMessage());
    }
    return compra; // Retorna el objeto Compra o null si no se encontró
}

public void eliminarDetallesPorIdCompra(int idCompra) {
    try {
        String query = "DELETE FROM compras_detalle WHERE id_compra = ?";
        PreparedStatement parametro = cn.conexionDB.prepareStatement(query);
        parametro.setInt(1, idCompra);
        parametro.executeUpdate(); // Ejecutar la consulta
    } catch (SQLException ex) {
        System.out.println("Error al eliminar detalles: " + ex.getMessage());
    }
}
    // Método para agregar detalles de compra

public void agregarCompraYDetalles(Compras compra, List<DetalleCompra> detalles) {
    PreparedStatement parametroCompra = null;
    PreparedStatement parametroDetalle = null;
    PreparedStatement parametroProducto = null;

    try {
        cn = new Conexion(); // Inicializa la conexión
        cn.abrir_conexion(); // Abre la conexión

        // 1. Insertar en la tabla compras
        String queryCompra = "INSERT INTO compras (no_orden_compra, id_proveedor, fecha_orden, fecha_ingreso) VALUES (?, ?, ?, ?)";
        parametroCompra = cn.conexionDB.prepareStatement(queryCompra, PreparedStatement.RETURN_GENERATED_KEYS);
        
        parametroCompra.setInt(1, compra.getNo_orden_compra());
        parametroCompra.setInt(2, compra.getId_proveedor());
        parametroCompra.setString(3, compra.getFecha_orden());
        parametroCompra.setString(4, compra.getFecha_ingreso());

        // Ejecutar la consulta de compra
        parametroCompra.executeUpdate();

        // Obtener el ID de la compra recién creada
        ResultSet generatedKeys = parametroCompra.getGeneratedKeys();
        int idNuevaCompra = 0;
        if (generatedKeys.next()) {
            idNuevaCompra = generatedKeys.getInt(1); // ID de la nueva compra
        }

        // 2. Insertar en la tabla compras_detalle
        String queryDetalle = "INSERT INTO compras_detalle (id_compra, id_producto, cantidad, precio_costo_unitario) VALUES (?, ?, ?, ?)";
        parametroDetalle = cn.conexionDB.prepareStatement(queryDetalle);

        for (DetalleCompra detalle : detalles) {
            detalle.setId_compra(idNuevaCompra); // Establecer el ID de compra

            parametroDetalle.setInt(1, detalle.getId_compra());
            parametroDetalle.setInt(2, detalle.getId_producto());
            parametroDetalle.setInt(3, detalle.getCantidad());
            parametroDetalle.setDouble(4, detalle.getPrecio_costo_unitario());

            // Ejecutar la consulta de detalle
            parametroDetalle.executeUpdate();

            // 3. Actualizar el saldo del producto y los precios
            String queryProducto = "UPDATE productos SET existencia = existencia + ?, precio_costo = ?, precio_venta = ? WHERE id_producto = ?";
            parametroProducto = cn.conexionDB.prepareStatement(queryProducto);
            
            double nuevoPrecioCosto = detalle.getPrecio_costo_unitario(); // Precio costo ingresado
            double nuevoPrecioVenta = nuevoPrecioCosto * 1.25; // Precio venta con un 25% más

            parametroProducto.setInt(1, detalle.getCantidad()); // Aumentar existencia
            parametroProducto.setDouble(2, nuevoPrecioCosto); // Actualizar precio costo
            parametroProducto.setDouble(3, nuevoPrecioVenta); // Actualizar precio venta
            parametroProducto.setInt(4, detalle.getId_producto()); // ID del producto

            // Ejecutar actualización del producto
            parametroProducto.executeUpdate();
        }

    } catch (SQLException ex) {
        System.out.println("Error al agregar compra y detalles: " + ex.getMessage());
    } finally {
        try {
            if (parametroCompra != null) {
                parametroCompra.close();
            }
            if (parametroDetalle != null) {
                parametroDetalle.close();
            }
            if (parametroProducto != null) {
                parametroProducto.close();
            }
            if (cn != null) {
                cn.cerrar_conexion(); // Cierra la conexión
            }
        } catch (SQLException e) {
            System.out.println("Error al cerrar recursos: " + e.getMessage());
        }
    }
}

public void actualizarCompraYDetalles(Compras compra, List<DetalleCompra> detalles) {
    PreparedStatement parametroCompra = null;
    PreparedStatement parametroDetalle = null;
    PreparedStatement parametroProducto = null;

    try {
        cn = new Conexion(); // Inicializa la conexión
        cn.abrir_conexion(); // Abre la conexión

        // 1. Actualizar en la tabla compras
        String queryCompra = "UPDATE compras SET no_orden_compra = ?, id_proveedor = ?, fecha_orden = ?, fecha_ingreso = ? WHERE id_compra = ?";
        parametroCompra = cn.conexionDB.prepareStatement(queryCompra);
        
        parametroCompra.setInt(1, compra.getNo_orden_compra());
        parametroCompra.setInt(2, compra.getId_proveedor());
        parametroCompra.setString(3, compra.getFecha_orden());
        parametroCompra.setString(4, compra.getFecha_ingreso());
        parametroCompra.setInt(5, compra.getId_compra());

        // Ejecutar la consulta de actualización de compra
        parametroCompra.executeUpdate();

        // 2. Eliminar los detalles existentes antes de agregar los nuevos
        eliminarDetallesPorIdCompra(compra.getId_compra()); // Método para eliminar detalles existentes

        // 3. Insertar los nuevos detalles y actualizar productos
        String queryDetalle = "INSERT INTO compras_detalle (id_compra, id_producto, cantidad, precio_costo_unitario) VALUES (?, ?, ?, ?)";
        parametroDetalle = cn.conexionDB.prepareStatement(queryDetalle);

        for (DetalleCompra detalle : detalles) {
            detalle.setId_compra(compra.getId_compra()); // Establecer el ID de compra

            // Insertar el detalle
            parametroDetalle.setInt(1, detalle.getId_compra());
            parametroDetalle.setInt(2, detalle.getId_producto());
            parametroDetalle.setInt(3, detalle.getCantidad());
            parametroDetalle.setDouble(4, detalle.getPrecio_costo_unitario());

            // Ejecutar la consulta de detalle
            parametroDetalle.executeUpdate();

            // 4. Actualizar el saldo del producto y los precios
            String queryProducto = "UPDATE productos SET existencia = existencia + ?, precio_costo = ?, precio_venta = ? WHERE id_producto = ?";
            parametroProducto = cn.conexionDB.prepareStatement(queryProducto);
            
            double nuevoPrecioCosto = detalle.getPrecio_costo_unitario(); // Precio costo ingresado
            double nuevoPrecioVenta = nuevoPrecioCosto * 1.25; // Precio venta con un 25% más

            parametroProducto.setInt(1, detalle.getCantidad()); // Aumentar existencia
            parametroProducto.setDouble(2, nuevoPrecioCosto); // Actualizar precio costo
            parametroProducto.setDouble(3, nuevoPrecioVenta); // Actualizar precio venta
            parametroProducto.setInt(4, detalle.getId_producto()); // ID del producto

            // Ejecutar actualización del producto
            parametroProducto.executeUpdate();
        }

    } catch (SQLException ex) {
        System.out.println("Error al actualizar compra y detalles: " + ex.getMessage());
    } finally {
        try {
            if (parametroCompra != null) {
                parametroCompra.close();
            }
            if (parametroDetalle != null) {
                parametroDetalle.close();
            }
            if (parametroProducto != null) {
                parametroProducto.close();
            }
            if (cn != null) {
                cn.cerrar_conexion(); // Cierra la conexión
            }
        } catch (SQLException e) {
            System.out.println("Error al cerrar recursos: " + e.getMessage());
        }
    }
}
public boolean eliminarCompraYDetalles(int idCompra) {
    PreparedStatement parametroDetalle = null;
    PreparedStatement parametroCompra = null;

    try {
        cn = new Conexion(); // Inicializa la conexión
        cn.abrir_conexion(); // Abre la conexión

        // 1. Eliminar los detalles de la compra
        String queryDetalle = "DELETE FROM compras_detalle WHERE id_compra = ?";
        parametroDetalle = cn.conexionDB.prepareStatement(queryDetalle);
        parametroDetalle.setInt(1, idCompra);
        parametroDetalle.executeUpdate(); // Ejecutar la consulta para eliminar detalles

        // 2. Eliminar la compra
        String queryCompra = "DELETE FROM compras WHERE id_compra = ?";
        parametroCompra = cn.conexionDB.prepareStatement(queryCompra);
        parametroCompra.setInt(1, idCompra);
        int filasAfectadas = parametroCompra.executeUpdate(); // Ejecutar la consulta para eliminar compra

        return filasAfectadas > 0; // Retorna true si se eliminó al menos una fila

    } catch (SQLException ex) {
        System.out.println("Error al eliminar compra y detalles: " + ex.getMessage());
        return false; // Retorna false si hubo un error
    } finally {
        try {
            if (parametroDetalle != null) {
                parametroDetalle.close();
            }
            if (parametroCompra != null) {
                parametroCompra.close();
            }
            if (cn != null) {
                cn.cerrar_conexion(); // Cierra la conexión
            }
        } catch (SQLException e) {
            System.out.println("Error al cerrar recursos: " + e.getMessage());
        }
    }
}


}
