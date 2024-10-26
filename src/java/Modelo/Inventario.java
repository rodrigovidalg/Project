package Modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Inventario {
    private int idProducto;
    private String producto;
    private String descripcion;
    private double precioCosto;
    private double precioVenta;
    private int existencia;
    private String fechaIngreso;

    // Constructor sin parámetros
    public Inventario() {
    }

    // Constructor con parámetros
    public Inventario(int idProducto, String producto, String descripcion, double precioCosto, double precioVenta, int existencia, String fechaIngreso) {
        this.idProducto = idProducto;
        this.producto = producto;
        this.descripcion = descripcion;
        this.precioCosto = precioCosto;
        this.precioVenta = precioVenta;
        this.existencia = existencia;
        this.fechaIngreso = fechaIngreso;
    }

    // Getters y Setters
    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public String getProducto() {
        return producto;
    }

    public void setProducto(String producto) {
        this.producto = producto;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public double getPrecioCosto() {
        return precioCosto;
    }

    public void setPrecioCosto(double precioCosto) {
        this.precioCosto = precioCosto;
    }

    public double getPrecioVenta() {
        return precioVenta;
    }

    public void setPrecioVenta(double precioVenta) {
        this.precioVenta = precioVenta;
    }

    public int getExistencia() {
        return existencia;
    }

    public void setExistencia(int existencia) {
        this.existencia = existencia;
    }

    public String getFechaIngreso() {
        return fechaIngreso;
    }

    public void setFechaIngreso(String fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    // Método para agregar producto
    public int agregar(Connection conexion) throws SQLException {
        String query = "INSERT INTO productos (producto, descripcion, precio_costo, precio_venta, existencia, fecha_ingreso) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conexion.prepareStatement(query)) {
            ps.setString(1, this.producto);
            ps.setString(2, this.descripcion);
            ps.setDouble(3, this.precioCosto);
            ps.setDouble(4, this.precioVenta);
            ps.setInt(5, this.existencia);
            ps.setString(6, this.fechaIngreso);
            return ps.executeUpdate();
        }
    }

    // Método para actualizar producto
    public int actualizar(Connection conexion) throws SQLException {
        String query = "UPDATE productos SET producto = ?, descripcion = ?, precio_costo = ?, precio_venta = ?, existencia = ?, fecha_ingreso = ? WHERE id_producto = ?";
        try (PreparedStatement ps = conexion.prepareStatement(query)) {
            ps.setString(1, this.producto);
            ps.setString(2, this.descripcion);
            ps.setDouble(3, this.precioCosto);
            ps.setDouble(4, this.precioVenta);
            ps.setInt(5, this.existencia);
            ps.setString(6, this.fechaIngreso);
            ps.setInt(7, this.idProducto);
            return ps.executeUpdate();
        }
    }

    // Método para eliminar producto
    public int eliminar(Connection conexion) throws SQLException {
        String query = "DELETE FROM productos WHERE id_producto = ?";
        try (PreparedStatement ps = conexion.prepareStatement(query)) {
            ps.setInt(1, this.idProducto);
            return ps.executeUpdate();
        }
    }
}
