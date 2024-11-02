/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.HashMap;
import javax.swing.table.DefaultTableModel;
/**
 *
 * @author Christian
 */
public class Cliente extends Persona {
    private int id;
    private String nit, correo_elec;
    Conexion cn;
    
    public Cliente (){};
    public Cliente(int id, String nombres, String apellidos, String nit, boolean genero, String telefono, String correo_elec, String fecha_ingreso) {
        super(nombres, apellidos, telefono, genero, fecha_ingreso);
        this.id = id;
        this.nit = nit;
        this.correo_elec = correo_elec;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNit() {
        return nit;
    }

    public void setNit(String nit) {
        this.nit = nit;
    }

    public String getCorreo_elec() {
        return correo_elec;
    }

    public void setCorreo_elec(String correo_elec) {
        this.correo_elec = correo_elec;
    }
    
    // Método para agregar un cliente
    @Override
    public int agregar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "INSERT INTO clientes(nombres, apellidos, nit, genero, telefono, correo_electronico, fecha_ingreso) VALUES(?, ?, ?, ?, ?, ?, ?);";
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setString(1, getNombres());
            parametro.setString(2, getApellidos());
            parametro.setString(3, getNit());
            parametro.setBoolean(4, getGenero());
            parametro.setString(5, getTelefono());
            parametro.setString(6, getCorreo_elec());
            parametro.setString(7, getFecha_ingreso());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error en agregar: " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

    // Método para leer clientes
    public DefaultTableModel leer() {
        DefaultTableModel tabla = new DefaultTableModel();
        try {
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "SELECT `id_cliente`,`nombres`,`apellidos`,`nit`,`genero`,`telefono`,`correo_electronico`,`fecha_ingreso` FROM `clientes`;";
            ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
            String encabezado[] = {"id", "nombres", "apellidos", "nit", "genero", "telefono", "correo_electronico", "fecha_ingreso"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[8];  // Ajustado a 8 para coincidir con los encabezados
            while (consulta.next()) {
                datos[0] = consulta.getString("id_cliente");
                datos[1] = consulta.getString("nombres");
                datos[2] = consulta.getString("apellidos");
                datos[3] = consulta.getString("nit");
                datos[4] = consulta.getBoolean("genero") ? "M" : "F";
                datos[5] = consulta.getString("telefono");
                datos[6] = consulta.getString("correo_electronico");
                datos[7] = consulta.getString("fecha_ingreso");
                tabla.addRow(datos);
            }
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error en leer: " + ex.getMessage());
        }
        return tabla;
    }

    // Método para actualizar cliente
    @Override
    public int actualizar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "UPDATE clientes SET nombres = ?, apellidos = ?, nit = ?, genero = ?, telefono = ?, correo_electronico = ?, fecha_ingreso = ? WHERE id_cliente = ?;";
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setString(1, getNombres());
            parametro.setString(2, getApellidos());
            parametro.setString(3, getNit());
            parametro.setBoolean(4, getGenero());
            parametro.setString(5, getTelefono());
            parametro.setString(6, getCorreo_elec());
            parametro.setString(7, getFecha_ingreso());
            parametro.setInt(8, getId());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error en actualizar: " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

    // Método para eliminar cliente
    @Override
    public int eliminar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "DELETE FROM clientes WHERE id_cliente = ?;";
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, getId());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error en eliminar: " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

    // Método para buscar cliente por NIT
    public Cliente buscarPorNit(String nit) {
        Cliente cliente = null;
        try {
            cn.abrir_conexion();
            String query = "SELECT * FROM clientes WHERE nit = ?;";
            PreparedStatement parametro = cn.conexionDB.prepareStatement(query);
            parametro.setString(1, nit);
            ResultSet rs = parametro.executeQuery();
            if (rs.next()) {
                cliente = new Cliente(
                    rs.getInt("id_cliente"),
                    rs.getString("nombres"),
                    rs.getString("apellidos"),
                    rs.getString("nit"),
                    rs.getBoolean("genero"),
                    rs.getString("telefono"),
                    rs.getString("correo_electronico"),
                    rs.getString("fecha_ingreso")
                );
            }
            cn.cerrar_conexion();
        } catch (SQLException e) {
            System.out.println("Error en buscarPorNit: " + e.getMessage());
        }
        return cliente;
    }
    
    public HashMap drop_Cliente(){
        HashMap<String,String[]> drop = new HashMap ();
        try{
        cn = new Conexion ();
        String query= "SELECT id_cliente as id,nombres,apellidos FROM clientes;";
        cn.abrir_conexion();
        ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
        while (consulta.next()){
            String id = consulta.getString("id");
            String nombre = consulta.getString("nombres");
            String apellidos = consulta.getString("apellidos");
            drop.put(id, new String[]{nombre,apellidos});
        }
        cn.cerrar_conexion();
        }catch (SQLException ex){
            System.out.println(ex.getMessage());
        }
        return drop;    
    }
}
