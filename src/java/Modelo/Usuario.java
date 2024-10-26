/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Usuario {
    private Connection conexion;
    private Conexion conexionDB;

    public Usuario() {
        conexionDB = new Conexion();
        conexionDB.abrir_conexion();
        this.conexion = conexionDB.conexionDB;
    }

    public Empleado validar(String usuario, String password) {
        Empleado empleado = null;

        String sql = "SELECT * FROM usuario WHERE usuario = ? AND password = ?";
        try (PreparedStatement pst = conexion.prepareStatement(sql)) {
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

    public void cerrarConexion() {
        conexionDB.cerrar_conexion();
    }
}