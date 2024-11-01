/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.table.DefaultTableModel;
import java.sql.*;


/**
 *
 * @author Christian
 */
public class Ventas {
    private int id_venta;
    private int no_factura; 
    private String no_serie;
    private Date fecha_factura;
    private Date fecha_ingreso;
    private int id_cliente;
    private int id_empleado;
    Conexion cn;
    
    public Ventas(){};
    public Ventas(int id_venta, int no_factura, String no_serie, Date fecha_factura, Date fecha_ingreso, int id_cliente, int id_empleado) {
        this.id_venta = id_venta;
        this.no_factura = no_factura;
        this.no_serie = no_serie;
        this.fecha_factura = fecha_factura;
        this.fecha_ingreso = fecha_ingreso;
        this.id_cliente = id_cliente;
        this.id_empleado = id_empleado;
    }

    public int getId_venta() {
        return id_venta;
    }

    public void setId_venta(int id_venta) {
        this.id_venta = id_venta;
    }

    public int getNo_factura() {
        return no_factura;
    }

    public void setNo_factura(int no_factura) {
        this.no_factura = no_factura;
    }

    public String getNo_serie() {
        return no_serie;
    }

    public void setNo_serie(String no_serie) {
        this.no_serie = no_serie;
    }

    public Date getFecha_factura() {
        return fecha_factura;
    }

    public void setFecha_factura(Date fecha_factura) {
        this.fecha_factura = fecha_factura;
    }

    public Date getFecha_ingreso() {
        return fecha_ingreso;
    }

    public void setFecha_ingreso(Date fecha_ingreso) {
        this.fecha_ingreso = fecha_ingreso;
    }

    public int getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(int id_cliente) {
        this.id_cliente = id_cliente;
    }

    public int getId_empleado() {
        return id_empleado;
    }

    public void setId_empleado(int id_empleado) {
        this.id_empleado = id_empleado;
    }
    
    public DefaultTableModel leer() {
        DefaultTableModel tabla = new DefaultTableModel(); 
        try {
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "SELECT v.id_venta, v.no_factura, v.serie, DATE_FORMAT(v.fecha_factura, '%Y-%m-%d') AS fecha_factura, "
                       + "CONCAT(c.nombres, ' ', c.apellidos) AS nombre_cliente, "
                       + "CONCAT(e.nombres, ' ', e.apellidos) AS nombre_empleado, "
                       + "DATE_FORMAT(v.fecha_ingreso, '%Y-%m-%d') AS fecha_ingreso, "
                       + "vd.id_producto, p.producto, vd.cantidad, vd.precio_unitario "
                       + "FROM ventas v "
                       + "INNER JOIN cliente c ON v.id_cliente = c.id_cliente "
                       + "INNER JOIN empleados e ON v.id_empleado = e.id_empleado "
                       + "INNER JOIN ventas_detalle vd ON v.id_venta = vd.id_venta "
                       + "INNER JOIN productos p ON vd.id_producto = p.id_producto "
                       + "ORDER BY v.id_venta ASC;"; 

            ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);

            // Encabezado de la tabla
            String encabezado[] = {"ID Venta", "No. Factura", "Serie", "Fecha Factura", "Cliente", "Empleado", "Fecha Ingreso", "ID Producto", "Producto", "Cantidad", "Precio Unitario"};
            tabla.setColumnIdentifiers(encabezado);

            // Llenado de datos en cada fila
            String datos[] = new String[11];
            while (consulta.next()) {
                datos[0] = consulta.getString("id_venta");
                datos[1] = consulta.getString("no_factura");
                datos[2] = consulta.getString("serie");
                datos[3] = consulta.getString("fecha_factura");
                datos[4] = consulta.getString("nombre_cliente");
                datos[5] = consulta.getString("nombre_empleado");
                datos[6] = consulta.getString("fecha_ingreso");
                datos[7] = consulta.getString("id_producto");
                datos[8] = consulta.getString("producto");
                datos[9] = consulta.getString("cantidad");
                datos[10] = consulta.getString("precio_unitario");
                tabla.addRow(datos);
            }

            cn.cerrar_conexion();
        } catch(Exception ex) {
            System.out.println(ex.getMessage());
        }
        return tabla;
    }
    
    public int agregar(int no_factura, String no_serie, Date fecha_factura, int id_cliente, int id_empleado, Date fecha_ingreso, int id_producto, int cantidad, double precio_unitario) {
        int retorno = 0;
         try{
            cn = new Conexion();
            cn.abrir_conexion();
            String queryVentas = "INSERT INTO ventas (no_factura, serie, fecha_factura, id_cliente, id_empleado,fecha_ingreso) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = cn.conexionDB.prepareStatement(queryVentas, Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, no_factura);
            pstmt.setString(2, no_serie);
            pstmt.setDate(3, fecha_factura);  // Insertar como tipo Date
            pstmt.setInt(4, id_cliente);
            pstmt.setInt(5, id_empleado);
            pstmt.setDate(6, fecha_ingreso);  // Insertar como tipo Date
            pstmt.executeUpdate();
            
            // Obtener el ID generado de la venta
            ResultSet rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                retorno = rs.getInt(1); // Obtiene el ID generado por la inserción

                // Insertar en la tabla ventas_detalle
                String queryDetalle = "INSERT INTO ventas_detalle (id_venta, id_producto, cantidad, precio_unitario) VALUES (?, ?, ?, ?)";
                PreparedStatement pstmtDetalle = cn.conexionDB.prepareStatement(queryDetalle);
                pstmtDetalle.setInt(1, retorno); // Usar el ID generado de la venta
                pstmtDetalle.setInt(2, id_producto);
                pstmtDetalle.setInt(3, cantidad);
                pstmtDetalle.setDouble(4, precio_unitario);
                pstmtDetalle.executeUpdate();
            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage()); // Manejo de errores
            cn.cerrar_conexion(); // Siempre cierra la conexión
        }
        return id_venta; // Retorna el ID de la venta creada
    

    }
    
    public int modificar(int id_venta, int no_factura, String no_serie, Date fecha_factura, int id_cliente, int id_empleado, Date fecha_ingreso, int id_producto, int cantidad, double precio_unitario) {
    int filasAfectadas = 0; // Inicializa el contador de filas afectadas
    try {
        cn = new Conexion();
        cn.abrir_conexion();

        // Actualizar la venta
        String queryVentas = "UPDATE ventas SET no_factura=?, serie=?, fecha_factura=?, id_cliente=?, id_empleado=?, fecha_ingreso=? WHERE id_venta=?";
        PreparedStatement pstmt = cn.conexionDB.prepareStatement(queryVentas);
        pstmt.setInt(1, no_factura);
        pstmt.setString(2, no_serie);
        pstmt.setDate(3, fecha_factura);
        pstmt.setInt(4, id_cliente);
        pstmt.setInt(5, id_empleado);
        pstmt.setDate(6, fecha_ingreso);
        pstmt.setInt(7, id_venta);
        filasAfectadas += pstmt.executeUpdate(); // Obtén el número de filas afectadas

        // Actualizar los detalles de la venta
        String queryDetalle = "UPDATE ventas_detalle SET id_producto=?, cantidad=?, precio_unitario=? WHERE id_venta=?";
        PreparedStatement pstmtDetalle = cn.conexionDB.prepareStatement(queryDetalle);
        pstmtDetalle.setInt(1, id_producto);
        pstmtDetalle.setInt(2, cantidad);
        pstmtDetalle.setDouble(3, precio_unitario);
        pstmtDetalle.setInt(4, id_venta); // Aquí asegúrate que el id_venta es correcto
        filasAfectadas += pstmtDetalle.executeUpdate(); // Obtén el número de filas afectadas

    } catch (SQLException e) {
        e.printStackTrace(); // Manejo de errores
        cn.cerrar_conexion(); // Cierra la conexión al final
    }
        return filasAfectadas; // Devuelve el número total de filas afectadas
    }


    public boolean eliminar(int id_venta) {
    boolean eliminado = false;
    try {
        cn = new Conexion();
        cn.abrir_conexion();

        // Primero eliminamos de la tabla ventas_detalle usando id_venta_detalle
        String queryDetalle = "DELETE FROM ventas_detalle WHERE id_venta = (SELECT id_venta FROM ventas WHERE id_venta = ?)";
        PreparedStatement pstmtDetalle = cn.conexionDB.prepareStatement(queryDetalle);
        pstmtDetalle.setInt(1, id_venta);
        pstmtDetalle.executeUpdate();

        // Luego eliminamos de la tabla ventas
        String queryVentas = "DELETE FROM ventas WHERE id_venta = ?";
        PreparedStatement pstmtVentas = cn.conexionDB.prepareStatement(queryVentas);
        pstmtVentas.setInt(1, id_venta);
        int filasAfectadas = pstmtVentas.executeUpdate();

        if (filasAfectadas > 0) {
            eliminado = true; // Si se eliminaron filas en ventas, la eliminación fue exitosa
        }
        
        
    } catch (SQLException ex) {
        System.out.println(ex.getMessage()); // Manejo de errores
        cn.cerrar_conexion();
    }
    return eliminado; // Devuelve true si se eliminó con éxito
}


}
