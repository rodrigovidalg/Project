/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.table.DefaultTableModel;
/**
 *
 * @author user
 */
public class Compras {
    private int id_compra;
    private int no_orden_compra; // Este será igual a id_compra
    private int id_proveedor;
    private String fecha_orden;
    private String fecha_ingreso;
    Conexion cn;

    public Compras(){}
    public Compras(int idCompra, int no_orden_compra, int idProveedor, String fechaOrden, String fechaIngreso) {
        this.id_compra = idCompra; 
        this.no_orden_compra = no_orden_compra; // Asignar el mismo valor
        this.id_proveedor = idProveedor;
        this.fecha_orden = fechaOrden;
        this.fecha_ingreso = fechaIngreso;
    }

    
    public int getId_compra() {
        return id_compra;
    }

    public void setId_compra(int id_compra) {
        this.id_compra = id_compra;
        this.no_orden_compra = id_compra;
    }


    public int getId_proveedor() {
        return id_proveedor;
    }

    public void setId_proveedor(int id_proveedor) {
        this.id_proveedor = id_proveedor;
    }

    public int getNo_orden_compra() {
        return no_orden_compra;
    }

    public void setNo_orden_compra(int no_orden_compra) {
        this.no_orden_compra = no_orden_compra;
    }

    public String getFecha_orden() {
        return fecha_orden;
    }

    public void setFecha_orden(String fecha_orden) {
        this.fecha_orden = fecha_orden;
    }

    public String getFecha_ingreso() {
        return fecha_ingreso;
    }

    public void setFecha_ingreso(String fecha_ingreso) {
        this.fecha_ingreso = fecha_ingreso;
    }
    
    
    public int obtenerUltimoNum() {
        int ultimoNumero = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            cn.abrir_conexion();

            String query = "SELECT no_orden_compra FROM compras ORDER BY no_orden_compra DESC LIMIT 1;";
            parametro = cn.conexionDB.prepareStatement(query);
            ResultSet rs = parametro.executeQuery();

            if (rs.next()) {
                ultimoNumero = rs.getInt("no_orden_compra");
            }

            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error al obtener último número de orden: " + ex.getMessage());
        }
        return ultimoNumero;
    }
    
   public int agregar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            cn.abrir_conexion();

            // Consulta SQL para insertar una nueva compra
            String query = "INSERT INTO compras (no_orden_compra, id_proveedor, fecha_orden, fecha_ingreso) VALUES (?, ?, ?, ?)";
            parametro = cn.conexionDB.prepareStatement(query);

            parametro.setInt(1, no_orden_compra); // Almacenar como INT
            parametro.setInt(2, id_proveedor);
            parametro.setString(3, fecha_orden);
            parametro.setString(4, fecha_ingreso);
            
            retorno = parametro.executeUpdate(); // Ejecutar la consulta
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Algo salió mal: " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }


public DefaultTableModel leer() {
    DefaultTableModel tabla = new DefaultTableModel();
    try {
        cn = new Conexion();
        cn.abrir_conexion();
        
        // Consulta SQL para obtener los datos de las compras, ordenados por no_orden_compra
        String query = "SELECT c.id_compra, c.no_orden_compra, c.fecha_orden, c.fecha_ingreso, " +
                       "p.id_proveedor, p.proveedor, cd.cantidad, cd.precio_costo_unitario, pr.id_producto, pr.producto " +
                       "FROM compras AS c " +
                       "INNER JOIN proveedores AS p ON c.id_proveedor = p.id_proveedor " +
                       "INNER JOIN compras_detalle AS cd ON c.id_compra = cd.id_compra " +
                       "INNER JOIN productos AS pr ON cd.id_producto = pr.id_producto " +
                       "ORDER BY c.id_compra ASC;"; // Asegúrate de ordenar por no_orden_compra
        ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
        
        // Encabezados de la tabla
        String encabezado[] = {"ID Compra", "Número de Orden", "ID Proveedor", "Proveedor", 
                                "Fecha de Orden", "Fecha de Ingreso", 
                                "ID Producto", "Producto", 
                                "Cantidad", "Precio Unitario"};
        tabla.setColumnIdentifiers(encabezado);
        
        // Datos
         while (consulta.next()) {
            Object[] datos = new Object[10];
            datos[0] = consulta.getString("id_compra");
            datos[1] = consulta.getString("no_orden_compra");
            datos[2] = consulta.getString("fecha_orden");
            datos[3] = consulta.getString("fecha_ingreso");
            datos[4] = consulta.getString("proveedor");
            datos[5] = consulta.getString("id_proveedor");
            datos[6] = consulta.getString("id_producto");
            datos[7] = consulta.getString("producto");
            datos[8] = consulta.getInt("cantidad");
            datos[9] = consulta.getDouble("precio_costo_unitario");
            tabla.addRow(datos);
        }
        
        cn.cerrar_conexion();
    } catch (SQLException ex) {
        System.out.println(ex.getMessage());
    }
    return tabla;
}
   
public int actualizar() {
    int retorno = 0;
    try {
        PreparedStatement parametro;
        cn = new Conexion();
        cn.abrir_conexion();

        // Consulta SQL para actualizar una compra
        String query = "UPDATE compras SET id_proveedor = ?, fecha_orden = ?, fecha_ingreso = ? WHERE id_compra = ?;";
        parametro = cn.conexionDB.prepareStatement(query);

        // Establecer los parámetros
        parametro.setInt(1, this.id_proveedor);
        parametro.setString(2, this.fecha_orden);
        parametro.setString(3, this.fecha_ingreso);
        parametro.setInt(4, this.id_compra); // ID de compra

        retorno = parametro.executeUpdate(); // Ejecutar la consulta
        cn.cerrar_conexion();
    } catch (SQLException ex) {
        System.out.println("Algo salió mal: " + ex.getMessage());
        retorno = 0;
    }
    return retorno;
}
   public int eliminar() {
    int retorno = 0;
    try {
        PreparedStatement parametro;
        cn = new Conexion();
        cn.abrir_conexion();
        
        // Consulta SQL para eliminar una compra
        String query = "DELETE FROM compras WHERE id_compra = ?;";
        parametro = cn.conexionDB.prepareStatement(query);
        
        // Establecer el parámetro
        parametro.setInt(1, this.getId_compra()); // Asegúrate de que el ID esté establecido
        
        retorno = parametro.executeUpdate(); // Ejecutar la consulta
        cn.cerrar_conexion();
    } catch (SQLException ex) {
        System.out.println("Error al borrar: " + ex.getMessage());
    }
    return retorno;
}


}
