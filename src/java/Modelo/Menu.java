package Modelo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Menu {
    private int id;
    private String nombre;
    private Integer ramaPadre; // Permite null para los menús principales
    private int posicion;
    private Conexion cn;

    // Constructor por defecto
    public Menu() {
        cn = new Conexion();
    }

    // Constructor sobrecargado
    public Menu(int id, String nombre, Integer ramaPadre, int posicion) {
        this.id = id;
        this.nombre = nombre;
        this.ramaPadre = ramaPadre;
        this.posicion = posicion;
        cn = new Conexion();
    }

    // Getters y setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Integer getRamaPadre() {
        return ramaPadre;
    }

    public void setRamaPadre(Integer ramaPadre) {
        this.ramaPadre = ramaPadre;
    }

    public int getPosicion() {
        return posicion;
    }

    public void setPosicion(int posicion) {
        this.posicion = posicion;
    }

    public List<Menu> obtenerMenus() {
        List<Menu> menus = new ArrayList<>();
        String query = "SELECT id_menu, nombre, rama_padre, posicion FROM menus ORDER BY rama_padre, posicion";

        try {
            // Abrimos la conexión
            cn.abrir_conexion();
            Connection connection = cn.conexionDB;

            try (PreparedStatement stmt = connection.prepareStatement(query);
                 ResultSet rs = stmt.executeQuery()) {

                // Recorremos los resultados y agregamos los menús a la lista
                while (rs.next()) {
                    Menu menu = new Menu(
                        rs.getInt("id_menu"),
                        rs.getString("nombre"),
                        (Integer) rs.getObject("rama_padre"),
                        rs.getInt("posicion")
                    );
                    menus.add(menu);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Manejo de errores de SQL
        } finally {
            // Cerramos la conexión al finalizar
            cn.cerrar_conexion();
        }

        return menus;
    }

    // Método para obtener submenús
    public List<Menu> obtenerSubMenus(List<Menu> allMenus) {
        List<Menu> subMenus = new ArrayList<>();
        for (Menu menu : allMenus) {
            if (this.id == menu.getRamaPadre()) {
                subMenus.add(menu);
            }
        }
        return subMenus;
    }
}
