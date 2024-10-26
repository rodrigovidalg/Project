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
 * @author DELL
 */
public class Proveedores {
    private int id;
    private String proveedor, nit, direccion, telefono;
    Conexion cn;
    public Proveedores(){}

    public Proveedores(int id, String proveedor, String nit, String direccion, String telefono) {
        this.id = id;
        this.proveedor = proveedor;
        this.nit = nit;
        this.direccion = direccion;
        this.telefono = telefono;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProveedor() {
        return proveedor;
    }

    public void setProveedor(String proveedor) {
        this.proveedor = proveedor;
    }

    public String getNit() {
        return nit;
    }

    public void setNit(String nit) {
        this.nit = nit;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public int agregar() {
        int retorno = 0;
        try{
            PreparedStatement parametro;
            cn= new Conexion();
            cn.abrir_conexion();
            String query = "INSERT INTO proveedores(proveedor, nit, direccion, telefono) VALUES(?, ?, ?, ?);";
            parametro = (PreparedStatement) cn.conexionDB.prepareStatement(query);
            parametro.setString(1, getProveedor());
            parametro.setString(2, getNit());
            parametro.setString(3, getDireccion());
            parametro.setString(4, getTelefono());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch(SQLException ex){
            System.out.println("Algo salio mal : " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }
    
    
    public DefaultTableModel leer(){
        DefaultTableModel tabla = new DefaultTableModel();
        try{
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "SELECT * FROM proveedores;";
            ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
            String encabezado[] = {"id", "proveedor","nit","direccion", "telefono"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String [5];
            while(consulta.next()){
                datos[0] = consulta.getString("id_proveedor");
                datos[1] = consulta.getString("proveedor");
                datos[2] = consulta.getString("nit");
                datos[3] = consulta.getString("direccion");
                datos[4] = consulta.getString("telefono");
                tabla.addRow(datos);
            }
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println("Error en leer " + ex.getMessage());
        }
            return tabla;
    }

    public int actualizar(){
        int retorno = 0;
        try{
            PreparedStatement parametro;
            cn= new Conexion();
            cn.abrir_conexion();
            String query = "UPDATE proveedores SET proveedor = ?, nit = ?, direccion = ?, telefono = ? WHERE id_proveedor = ?;";
            parametro = (PreparedStatement) cn.conexionDB.prepareStatement(query);
            parametro.setString(1, getProveedor());
            parametro.setString(2, getNit());
            parametro.setString(3, getDireccion());
            parametro.setString(4, getTelefono());
            parametro.setInt(5, this.getId());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch(SQLException ex){
            System.out.println("Algo salio mal : " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

    public int eliminar(){
        int retorno = 0;
        try{
            PreparedStatement parametro;
            cn= new Conexion();
            cn.abrir_conexion();
            String query = "DELETE FROM proveedores WHERE id_proveedor = ?;";
            parametro = (PreparedStatement) cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, getId());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch(SQLException ex){
            System.out.println("Error en borrar: " + ex.getMessage());
        }
        return retorno;
    }
    
}
