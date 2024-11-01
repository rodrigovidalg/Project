/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import javax.swing.table.DefaultTableModel;

 /*
 * @author DELL
 */
public class Puesto {
    private int id_Puesto; 
    private String nombre_puesto; 
    private Conexion cn; 

    public Puesto() {}

    public Puesto(int id_Puesto, String nombre_puesto) {
        this.id_Puesto = id_Puesto;
        this.nombre_puesto = nombre_puesto;
    }
    
    public int getId_Puesto() {
        return id_Puesto;
    }

    public void setId_Puesto(int id_Puesto) {
        this.id_Puesto = id_Puesto;
    }

    public String getNombre_puesto() {
        return nombre_puesto;
    }

    public void setNombre_puesto(String nombre_puesto) {
        this.nombre_puesto = nombre_puesto;
    }
    
    public HashMap drop_puesto(){
        HashMap<String, String> drop = new HashMap();
        try{
            cn = new Conexion();
            String query = "SELECT id_puesto as id,puesto FROM puestos;";
            cn.abrir_conexion();
            ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
            while (consulta.next()){
                drop.put(consulta.getString("id"), consulta.getString("puesto"));
            }
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
        return drop;
    }

    public int agregar() {
        int retorno =0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "INSERT INTO puestos (puesto) VALUES (?);";
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setString(1, getNombre_puesto());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException e) {
            System.out.println("Error al agregar puesto: " + e.getMessage());
            retorno =0;
        }
        return retorno;
    }

    public DefaultTableModel leer() {
        DefaultTableModel tabla = new DefaultTableModel();
        try {
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "SELECT * FROM puestos;";
            ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
            String[] encabezado = {"ID Puesto", "Nombre del Puesto"};
            tabla.setColumnIdentifiers(encabezado);
            String[] datos = new String[2];
            while (consulta.next()) {
                datos[0] = consulta.getString("id_puesto");
                datos[1] = consulta.getString("puesto");
                tabla.addRow(datos);
            }
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error al leer puestos: " + ex.getMessage());
        }
        return tabla;
    }

    public int actualizar() {
        int retorno =0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "UPDATE puestos SET puesto = ? WHERE id_puesto = ?;";
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setString(1, getNombre_puesto());
            parametro.setInt(2, getId_Puesto());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException e) {
            System.out.println("Error al actualizar puesto: " + e.getMessage());
            retorno =0;
        }
        return retorno;
    }

    // Método para eliminar un puesto
    public int eliminar() {
        int retorno =0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "DELETE FROM puestos WHERE id_puesto = ?;";
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, getId_Puesto());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException e) {
            System.out.println("Error al eliminar puesto: " + e.getMessage());
            retorno =0;
        }
        return retorno;
    }

    
}