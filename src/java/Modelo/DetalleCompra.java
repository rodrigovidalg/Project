
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
public class DetalleCompra {
    private int id_compras_detalle;
    private int id_compra;
    private int id_producto;
    private int cantidad;
    private double precio_costo_unitario;
    Conexion cn;

    public DetalleCompra(){
        
    }
    public DetalleCompra(int id_compras_detalle, int id_compra, int id_producto, int cantidad, double precio_costo_unitario) {
        this.id_compras_detalle = id_compras_detalle;
        this.id_compra = id_compra;
        this.id_producto = id_producto;
        this.cantidad = cantidad;
        this.precio_costo_unitario = precio_costo_unitario;
    }

    public int getId_compras_detalle() {
        return id_compras_detalle;
    }

    public void setId_compras_detalle(int id_compras_detalle) {
        this.id_compras_detalle = id_compras_detalle;
    }

    public int getId_compra() {
        return id_compra;
    }

    public void setId_compra(int id_compra) {
        this.id_compra = id_compra;
    }

    public int getId_producto() {
        return id_producto;
    }

    public void setId_producto(int id_producto) {
        this.id_producto = id_producto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public double getPrecio_costo_unitario() {
        return precio_costo_unitario;
    }

    public void setPrecio_costo_unitario(double precio_costo_unitario) {
        this.precio_costo_unitario = precio_costo_unitario;
    }
    
    public int agregar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;


            // Consulta SQL para insertar una nueva compra
            String query = "INSERT INTO compras_detalle (id_compra, id_producto, cantidad, precio_costo_unitario) VALUES (?, ?, ?, ?)";
            parametro = cn.conexionDB.prepareStatement(query);

            parametro.setInt(1, this.getId_compra()); // Almacenar como INT
            parametro.setInt(2, this.getId_producto());
            parametro.setInt(3, this.getCantidad());
            parametro.setDouble(4, this.getPrecio_costo_unitario());
            
            retorno = parametro.executeUpdate(); // Ejecutar la consulta
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Algo salió mal: " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }
}
