package Modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import javax.swing.table.DefaultTableModel;

public class Marca {
    private int id;
    private String marca;
    private Conexion cn;

    public Marca() {}

    public Marca(int id, String marca) {
        this.id = id;
        this.marca = marca;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public HashMap drop_marca(){
        HashMap<String, String> drop = new HashMap();
        try{
            cn = new Conexion();
            String query = "SELECT id_marca as id,marca FROM marcas;";
            cn.abrir_conexion();
            ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
            while (consulta.next()){
                drop.put(consulta.getString("id"), consulta.getString("marca"));
            }
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
        return drop;
    }

    public void agregar() {
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "INSERT INTO marcas (marca) VALUES (?);";
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setString(1, getMarca());
            int ejecutar = parametro.executeUpdate();
            System.out.println("Marca agregado correctamente: " + ejecutar);
            cn.cerrar_conexion();
        } catch (SQLException e) {
            System.out.println("Error al agregar marca: " + e.getMessage());
        }
    }

    public DefaultTableModel leer() {
        DefaultTableModel tablaP = new DefaultTableModel();
        try {
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "SELECT * FROM marcas;";
            ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
            String[] encabezado = {"ID Marca", "Nombre de la Marca"};
            tablaP.setColumnIdentifiers(encabezado);
            String[] datos = new String[2];
            while (consulta.next()) {
                datos[0] = consulta.getString("id_marca");
                datos[1] = consulta.getString("marca");
                tablaP.addRow(datos);
            }
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error al leer marcas: " + ex.getMessage());
        }
        return tablaP;
    }

    public void actualizar() {
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "UPDATE marcas SET marca = ? WHERE id_marca = ?;";
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setString(1, getMarca());
            parametro.setInt(2, getId());
            int ejecutar = parametro.executeUpdate();
            System.out.println("Marca actualizado correctamente: " + ejecutar);
            cn.cerrar_conexion();
        } catch (SQLException e) {
            System.out.println("Error al actualizar marca: " + e.getMessage());
        }
    }

    public void eliminar() {
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "DELETE FROM marcas WHERE id_marca = ?;";
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, getId());
            int ejecutar = parametro.executeUpdate();
            System.out.println("Marca eliminado correctamente: " + ejecutar);
            cn.cerrar_conexion();
        } catch (SQLException e) {
            System.out.println("Error al eliminar marca: " + e.getMessage());
        }
    }
}
