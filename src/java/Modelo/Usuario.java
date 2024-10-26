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
public class Usuario {
    private int id;
    private String user, pass, rol;
    private Conexion cn;
    private ResultSet rs;

    
    public Usuario(){}

    public Usuario(int id, String user, String pass, String rol) {
        this.id = id;
        this.user = user;
        this.pass = pass;
        this.rol = rol;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }
    
    public Empleado validar(String usuario, String password) {
        Empleado empleado = null;
        String sql = "SELECT * FROM usuarios WHERE usuario = ? AND password = ?";
        
        try {
            cn = new Conexion(); // Inicializa la conexión
            cn.abrir_conexion();
            PreparedStatement pst = cn.conexionDB.prepareStatement(sql);
            pst.setString(1, usuario);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                empleado = new Empleado();
                empleado.setId(rs.getInt("id_usuario"));
                empleado.setNombres(rs.getString("usuario"));
                empleado.setRol(rs.getString("rol"));
            }
        } catch (SQLException ex) {
            System.out.println("Error en la validación: " + ex.getMessage());
        }
        return empleado; // Retorna null si no se encuentra el usuario
    }

    public DefaultTableModel leer() {
    DefaultTableModel tabla = new DefaultTableModel();
    try {
        cn = new Conexion();
        cn.abrir_conexion();
        
        // Consulta SQL para obtener el nombre del puesto en vez del ID
        String query = "SELECT u.id_usuario as id, u.usuario, u.password, p.puesto FROM usuarios as u INNER JOIN puestos as p ON u.rol = p.id_puesto;";
        ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
        
        String[] encabezado = {"id", "usuario", "password", "puesto"};
        tabla.setColumnIdentifiers(encabezado);
        String[] datos = new String[4];
        
        while (consulta.next()) {
            datos[0] = consulta.getString("id"); // ID del usuario
            datos[1] = consulta.getString("usuario");
            datos[2] = consulta.getString("password");
            datos[3] = consulta.getString("puesto"); // Nombre del puesto
            tabla.addRow(datos);
        }
        
        cn.cerrar_conexion();
    } catch (SQLException ex) {
        System.out.println("Error al leer usuarios: " + ex.getMessage());
    }
    return tabla;
}
    
    public int agregar() {
        int retorno =0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "INSERT INTO usuarios (usuario,password,rol) VALUES (?,?,?);";
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setString(1, getUser());
            parametro.setString(2, getPass());
            parametro.setString(3, getRol());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException e) {
            System.out.println("Error al agregar usuario: " + e.getMessage());
            retorno =0;
        }
        return retorno;
    }

    public int actualizar() {
        int retorno =0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "UPDATE usuarios SET usuario = ?, password = ?, rol = ? WHERE id_usuario = ?;";
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setString(1, getUser());
            parametro.setString(2, getPass());
            parametro.setString(3, getRol());
            parametro.setInt(4, getId());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException e) {
            System.out.println("Error al actualizar usuario: " + e.getMessage());
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
            String query = "DELETE FROM usuarios WHERE id_usuario = ?;";
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, getId());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException e) {
            System.out.println("Error al eliminar usuario: " + e.getMessage());
            retorno=0;
        }
        return retorno;
    }
}