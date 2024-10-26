/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
/**
 *
 * @author Christian
 */
public class Producto {
    private int id, id_marca;
    private String producto, descripcion, imagen, precioC, preciov, existencia, fecha_ingreso;
    Conexion cn;
    
    public Producto(){};
    public Producto(int id, int id_marca, String producto, String descripcion, String imagen, String precioC, String preciov, String existencia, String fecha_ingreso) {
        this.id = id;
        this.id_marca = id_marca;
        this.producto = producto;
        this.descripcion = descripcion;
        this.imagen = imagen;
        this.precioC = precioC;
        this.preciov = preciov;
        this.existencia = existencia;
        this.fecha_ingreso = fecha_ingreso;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_marca() {
        return id_marca;
    }

    public void setId_marca(int id_marca) {
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

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public String getPrecioC() {
        return precioC;
    }

    public void setPrecioC(String precioC) {
        this.precioC = precioC;
    }

    public String getPreciov() {
        return preciov;
    }

    public void setPreciov(String preciov) {
        this.preciov = preciov;
    }

    public String getExistencia() {
        return existencia;
    }

    public void setExistencia(String existencia) {
        this.existencia = existencia;
    }

    public String getFecha_ingreso() {
        return fecha_ingreso;
    }

    public void setFecha_ingreso(String fecha_ingreso) {
        this.fecha_ingreso = fecha_ingreso;
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
    

