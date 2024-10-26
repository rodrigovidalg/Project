<%@ page import="java.sql.*" %>
<%@ page import="Modelo.Conexion" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inventario de Productos</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">
                    <h2 class="text-center mb-0">Inventario de Productos</h2>
                </div>
                <div class="card-body">
                    <form method="GET" action="Inventario.jsp" class="mb-4">
                        <div class="input-group">
                            <input type="text" name="search" class="form-control" placeholder="Buscar producto..." value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                            <button class="btn btn-primary" type="submit">Buscar</button>
                        </div>
                    </form>
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead class="table-secondary">
                                <tr>
                                    <th>ID</th>
                                    <th>Producto</th>
                                    <th>Marca</th>
                                    <th>Descripción</th>
                                    <th>Precio Costo</th>
                                    <th>Precio Venta</th>
                                    <th>Existencia</th>
                                    <th>Fecha de Ingreso</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Conexion cn = new Conexion();
                                    cn.abrir_conexion();
                                    Connection conexion = cn.conexionDB;
                                    String query = "SELECT * FROM productos";
                                    String searchParam = request.getParameter("search");
                                    if (searchParam != null && !searchParam.trim().isEmpty()) {
                                        query += " WHERE producto LIKE ? OR descripcion LIKE ?";
                                    }
                                    try {
                                        PreparedStatement stmt = conexion.prepareStatement(query);
                                        if (searchParam != null && !searchParam.trim().isEmpty()) {
                                            stmt.setString(1, "%" + searchParam + "%");
                                            stmt.setString(2, "%" + searchParam + "%");
                                        }
                                        ResultSet rs = stmt.executeQuery();
                                        while (rs.next()) {
                                %>
                                <tr>
                                    <td><%= rs.getInt("id_producto") %></td>
                                    <td><%= rs.getString("producto") %></td>
                                    <td><%= rs.getInt("id_marca") %></td>
                                    <td><%= rs.getString("descripcion") %></td>
                                    <td><%= rs.getDouble("precio_costo") %></td>
                                    <td><%= rs.getDouble("precio_venta") %></td>
                                    <td><%= rs.getInt("existencia") %></td>
                                    <td><%= rs.getString("fecha_ingreso") %></td>
                                    <td>
                                        <a href="sr_cInventario?action=delete&idProducto=<%= rs.getInt("id_producto") %>" class="btn btn-danger">Eliminar</a>
                                    </td>
                                </tr>
                                <%
                                        }
                                        rs.close();
                                        stmt.close();
                                    } catch (SQLException e) {
                                        out.println("<tr><td colspan='9' class='text-center'>Error al cargar los datos: " + e.getMessage() + "</td></tr>");
                                    } finally {
                                        cn.cerrar_conexion();
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
