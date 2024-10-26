package Modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class Producto {
    private int id;
    private int id_marca;
    private String producto;
    private String descripcion;
    private double precio_costo;
    private double precio_venta;
    private int existencia;
    private String fecha_ingreso;
    private Conexion cn;

    // Constructor vacío
    public Producto() {
        this.cn = new Conexion();
    }

    // Constructor con parámetros
    public Producto(int id, int id_marca, String producto, String descripcion, double precio_costo, double precio_venta, int existencia, String fecha_ingreso) {
        this.id = id;
        this.id_marca = id_marca;
        this.producto = producto;
        this.descripcion = descripcion;
        this.precio_costo = precio_costo;
        this.precio_venta = precio_venta;
        this.existencia = existencia;
        this.fecha_ingreso = fecha_ingreso;
        this.cn = new Conexion();
    }

    // Métodos getter y setter
    public int getIdProducto() {
        return id;
    }

    public void setIdProducto(int id) {
        this.id = id;
    }

    public int getIdMarca() {
        return id_marca;
    }

    public void setIdMarca(int id_marca) {
        this.id_marca = id_marca;
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
        return precio_costo;
    }

    public void setPrecioCosto(double precio_costo) {
        this.precio_costo = precio_costo;
    }

    public double getPrecioVenta() {
        return precio_venta;
    }

    public void setPrecioVenta(double precio_venta) {
        this.precio_venta = precio_venta;
    }

    public int getExistencia() {
        return existencia;
    }

    public void setExistencia(int existencia) {
        this.existencia = existencia;
    }

    public String getFechaIngreso() {
        return fecha_ingreso;
    }

    public void setFechaIngreso(String fecha_ingreso) {
        this.fecha_ingreso = fecha_ingreso;
    }

    // Método para listar los productos
    public List<Producto> listar() throws SQLException {
        List<Producto> listaProductos = new ArrayList<>();
        String sql = "SELECT * FROM productos";
        
        cn.abrir_conexion();
        Connection conexion = cn.conexionDB;
        try (PreparedStatement pst = conexion.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                Producto prod = new Producto();
                prod.setIdProducto(rs.getInt("id_producto"));
                prod.setIdMarca(rs.getInt("id_marca"));
                prod.setProducto(rs.getString("producto"));
                prod.setDescripcion(rs.getString("descripcion"));
                prod.setPrecioCosto(rs.getDouble("precio_costo"));
                prod.setPrecioVenta(rs.getDouble("precio_venta"));
                prod.setExistencia(rs.getInt("existencia"));
                prod.setFechaIngreso(rs.getString("fecha_ingreso"));
                listaProductos.add(prod);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar productos: " + e.getMessage());
            throw new SQLException("Error al listar productos: " + e.getMessage());
        } finally {
            cn.cerrar_conexion();
        }
        return listaProductos;
    }

    // Método para guardar un producto en la base de datos
    public boolean guardar() throws SQLException {
        boolean guardado = false;
        String sql = "INSERT INTO productos (id_marca, producto, descripcion, precio_costo, precio_venta, existencia, fecha_ingreso) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        cn.abrir_conexion();
        Connection conexion = cn.conexionDB;
        try {
            conexion.setAutoCommit(true);
            try (PreparedStatement pst = conexion.prepareStatement(sql)) {
                pst.setInt(1, this.getIdMarca());
                pst.setString(2, this.getProducto());
                pst.setString(3, this.getDescripcion());
                pst.setDouble(4, this.getPrecioCosto());
                pst.setDouble(5, this.getPrecioVenta());
                pst.setInt(6, this.getExistencia());
                pst.setString(7, this.getFechaIngreso());
                guardado = pst.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error al guardar el producto: " + e.getMessage());
            throw new SQLException("Error al guardar el producto: " + e.getMessage());
        } finally {
            cn.cerrar_conexion();
        }
        return guardado;
    }

    // Método para eliminar un producto de la base de datos
    public boolean eliminar() throws SQLException {
        boolean eliminado = false;
        String sql = "DELETE FROM productos WHERE id_producto = ?";
        
        cn.abrir_conexion();
        Connection conexion = cn.conexionDB;
        try (PreparedStatement pst = conexion.prepareStatement(sql)) {
            pst.setInt(1, this.getIdProducto());
            eliminado = pst.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new SQLException("Error al eliminar el producto: " + e.getMessage());
        } finally {
            cn.cerrar_conexion();
        }
        return eliminado;
    }
    public HashMap drop_sangre(){
    HashMap<String,String[]> drop = new HashMap ();
    try{
        cn = new Conexion ();
        String query= "SELECT p.id_producto AS id,p.producto,m.marca AS marca,p.precio_venta,p.existencia FROM productos p INNER JOIN marcas m ON p.id_marca = m.id_marca;";
        cn.abrir_conexion();
        ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
        while (consulta.next()){
            String id = consulta.getString("id");
            String nombre = consulta.getString("p.producto");
            String marca = consulta.getString("m.marca");
            String precio = consulta.getString("p.precio_venta");
            String existe = consulta.getString("p.existencia");
            drop.put(id, new String[]{nombre,marca, precio, existe});
        }
        cn.cerrar_conexion();
    }catch (SQLException ex){
        System.out.println(ex.getMessage());
    }
        return drop; 
    }
}
    

