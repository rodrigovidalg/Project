package Modelo;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import javax.swing.table.DefaultTableModel;

public class Producto {
    private int id;
    private String producto;
    private int id_marca;
    private String descripcion;
    private String imagen;
    private double precio_costo;
    private double precio_venta;
    private int existencia;
    private String fecha_ingreso;
    private Conexion cn;
    
    public Producto(){}

    public Producto(int id, String producto, int id_marca, String descripcion, String imagen, double precio_costo, double precio_venta, int existencia, String fecha_ingreso) {
        this.id = id;
        this.producto = producto;
        this.id_marca = id_marca;
        this.descripcion = descripcion;
        this.imagen = imagen;
        this.precio_costo = precio_costo;
        this.precio_venta = precio_venta;
        this.existencia = existencia;
        this.fecha_ingreso = fecha_ingreso;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProducto() {
        return producto;
    }

    public void setProducto(String producto) {
        this.producto = producto;
    }

    public int getId_marca() {
        return id_marca;
    }

    public void setId_marca(int id_marca) {
        this.id_marca = id_marca;
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

    public double getPrecio_costo() {
        return precio_costo;
    }

    public void setPrecio_costo(double precio_costo) {
        this.precio_costo = precio_costo;
    }

    public double getPrecio_venta() {
        return precio_venta;
    }

    public void setPrecio_venta(double precio_venta) {
        this.precio_venta = precio_venta;
    }

    public int getExistencia() {
        return existencia;
    }

    public void setExistencia(int existencia) {
        this.existencia = existencia;
    }

    public String getFecha_ingreso() {
        return fecha_ingreso;
    }

    public void setFecha_ingreso(String fecha_ingreso) {
        this.fecha_ingreso = fecha_ingreso;
    }

    public String guardarImagenEnServidor(File imagenArchivo) {
        String directorioDestino = "C:\\xampp\\htdocs\\imagenes_productos\\";
        String nombreArchivo = imagenArchivo.getName();
        Path destinoPath = Paths.get(directorioDestino + nombreArchivo);

        try {
            if (!Files.exists(Paths.get(directorioDestino))) {
                Files.createDirectories(Paths.get(directorioDestino));
            }
            Files.copy(imagenArchivo.toPath(), destinoPath);
            return "http://localhost/imagenes_productos/" + nombreArchivo; // URL accesible en el servidor
        } catch (IOException e) {
            System.out.println("Error al guardar la imagen en el servidor: " + e.getMessage());
            return null;
        }
    }


    public DefaultTableModel leer() {
        DefaultTableModel tabla = new DefaultTableModel();
        try {
            cn = new Conexion();  // Aseguramos la inicialización de la conexión.
            cn.abrir_conexion();
            String query = "SELECT p.id_producto as id, p.producto, p.descripcion, p.imagen, p.precio_costo, p.precio_venta, p.existencia, p.fecha_ingreso, m.marca FROM productos as p INNER JOIN marcas as m ON p.id_marca = m.id_marca;";
            ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
            String encabezado[] = {"id", "producto", "marca", "descripcion", "imagen", "precio costo", "precio venta", "existencia", "fecha ingreso"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[9];
            while (consulta.next()) {
                datos[0] = consulta.getString("id");
                datos[1] = consulta.getString("producto");
                datos[2] = consulta.getString("marca");
                datos[3] = consulta.getString("descripcion");
                datos[4] = consulta.getString("imagen");
                datos[5] = consulta.getString("precio_costo");
                datos[6] = consulta.getString("precio_venta");
                datos[7] = consulta.getString("existencia");
                datos[8] = consulta.getString("fecha_ingreso");
                tabla.addRow(datos);
            }
        } catch (SQLException ex) {
            System.out.println("Error en leer " + ex.getMessage());
        } finally {
            if (cn != null) {
                cn.cerrar_conexion(); // Cerramos la conexión solo si fue inicializada.
            }
        }
        return tabla;
    }

    public int agregar(File imagenArchivo) {
        int resultado = 0;
        String urlImagen = guardarImagenEnServidor(imagenArchivo);
        if (urlImagen != null) {
            this.imagen = urlImagen; // URL de la imagen
            String query = "INSERT INTO productos (producto, id_marca, descripcion, imagen, precio_costo, precio_venta, existencia, fecha_ingreso) VALUES (?, ?, ?, ?, ?, ?, ?, ?);";

            try {
                cn = new Conexion(); // Inicializamos la conexión
                cn.abrir_conexion();
                try (PreparedStatement parametro = cn.conexionDB.prepareStatement(query)) {
                    parametro.setString(1, producto);
                    parametro.setInt(2, id_marca);
                    parametro.setString(3, descripcion);
                    parametro.setString(4, imagen); // Almacena la URL en la base de datos
                    parametro.setDouble(5, precio_costo);
                    parametro.setDouble(6, precio_venta);
                    parametro.setInt(7, existencia);
                    parametro.setString(8, fecha_ingreso);
                    resultado = parametro.executeUpdate();
                }
            } catch (SQLException ex) {
                System.err.println("Error al agregar producto: " + ex.getMessage());
            } finally {
                if (cn != null) {
                    cn.cerrar_conexion(); // Cerramos la conexión solo si fue inicializada.
                }
            }
        }
        return resultado;
    }

    public int actualizar(File imagenArchivo) {
        int resultado = 0;
        String urlImagen = guardarImagenEnServidor(imagenArchivo);
        if (urlImagen != null) {
            this.imagen = urlImagen; // URL de la imagen
            String query = "UPDATE productos SET producto = ?, id_marca = ?, descripcion = ?, imagen = ?, precio_costo = ?, precio_venta = ?, existencia = ?, fecha_ingreso = ? WHERE id_producto = ?;";

            try {
                cn = new Conexion(); // Inicializamos la conexión
                cn.abrir_conexion();
                try (PreparedStatement parametro = cn.conexionDB.prepareStatement(query)) {
                    parametro.setString(1, producto);
                    parametro.setInt(2, id_marca);
                    parametro.setString(3, descripcion);
                    parametro.setString(4, imagen); // Almacena la URL en la base de datos
                    parametro.setDouble(5, precio_costo);
                    parametro.setDouble(6, precio_venta);
                    parametro.setInt(7, existencia);
                    parametro.setString(8, fecha_ingreso);
                    parametro.setInt(9, id);
                    resultado = parametro.executeUpdate();
                }
            } catch (SQLException ex) {
                System.err.println("Error al actualizar producto: " + ex.getMessage());
            } finally {
                if (cn != null) {
                    cn.cerrar_conexion(); // Cerramos la conexión solo si fue inicializada.
                }
            }
        }
        return resultado;
    }

    public int eliminar() {
        int resultado = 0;
        String query = "DELETE FROM productos WHERE id_producto = ?;";

        try {
            cn = new Conexion(); // Inicializamos la conexión
            cn.abrir_conexion();
            try (PreparedStatement parametro = cn.conexionDB.prepareStatement(query)) {
                parametro.setInt(1, id);
                resultado = parametro.executeUpdate();
            }
        } catch (SQLException ex) {
            System.err.println("Error al eliminar producto: " + ex.getMessage());
        } finally {
            if (cn != null) {
                cn.cerrar_conexion(); // Cerramos la conexión solo si fue inicializada.
            }
        }
        return resultado;
    }
    
    public HashMap drop_productos(){
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