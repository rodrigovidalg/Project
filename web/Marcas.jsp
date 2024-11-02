<%@ page import="Modelo.Marca" %>
<%@page import="java.util.HashMap"%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@ page import="Modelo.Conexion" %>
<%@ page import="java.sql.*" %>

<%@page import="Modelo.Empleado"%>
<%@page import="javax.servlet.http.HttpSession" %>

<%
    
    if (session == null || session.getAttribute("empleado") == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    Empleado empleado = (Empleado) session.getAttribute("empleado");
%>
<%
    response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gestión de Marcas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {background-color: #f5f5f5;font-family: Arial, sans-serif;}
        .container {max-width: 800px;}
        .card {border-radius: 15px; border: none; box-shadow: 0 4px 8px rgba(0,0,0,0.2);}
        .card-header {background: linear-gradient(90deg, #007bff, #0056b3);color: #ffffff;border-radius: 15px 15px 0 0;text-align: center;}
        .btn {border-radius: 50px;padding: 10px 20px;}
        .table thead {background-color: #007bff;color: white;}
        .table-hover tbody tr:hover {background-color: #f0f8ff;}
        .form-label {font-weight: bold;}
        .search-section {display: flex;justify-content: space-between;align-items: center;margin-bottom: 20px;}
        .search-section input {width: 70%;}
    </style>
</head>
<body>
    <div class="container mt-5">
        <!-- Formulario para ingresar una nueva marca -->
        <div class="card shadow-sm mb-5">
            <div class="card-header">
                <h2><i class="fas fa-tags"></i> Ingresar Nueva Marca</h2>
            </div>
            <div class="card-body">
                <form action="sr_cMarcas" method="post" onsubmit="saveScrollPosition()">
                    <div class="row mb-3">
                        <div class="col-md-1">
                            <label for="id" class="form-label">ID</label>
                            <input type="text" class="form-control" id="id_marca" name="idMarca" value="0" readonly>
                        </div>
                        <div class="col-md-8">
                            <label for="marca" class="form-label">Nombre de la Marca</label>
                            <input type="text" class="form-control" id="marca" name="marca" required>
                        </div>
                    </div>
                    <div class="text-center">
                        <button name="action" id="btn_agregar" value="agregar" class="btn btn-primary btn-lg"><i class="fas fa-plus-circle"></i> Agregar</button>
                        <button name="action" id="btn_actualizar" value="actualizar" class="btn btn-success btn-lg"><i class="fas fa-sync-alt"></i> Actualizar</button>
                        <button name="action" id="btn_eliminar" value="eliminar" class="btn btn-danger btn-lg" onclick="javascript:if(!confirm('Desea eliminar'))return false"><i class="fas fa-trash-alt"></i> Eliminar</button>
                        <button type="button" class="btn btn-warning btn-lg" onclick="limpiar()"><i class="fas fa-times-circle"></i> Cancelar</button>
                        <a href="Inventario.jsp" class="btn btn-secondary btn-lg"><i class="fas fa-clipboard-list"></i> Inventario</a>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- Buscador de marcas -->
        <div class="card mb-5">
            <div class="card-header text-white bg-primary text-center">
                <h2><i class="fas fa-search"></i> Buscar Marcas</h2>
            </div>
            <div class="card-body">
                <div class="search-section">
                    <input type="text" id="searchField" class="form-control" placeholder="Ingresa la marca a buscar...">
                    <button type="button" class="btn btn-primary" onclick="buscar()"><i class="fas fa-search"></i> Buscar</button>
                </div>
            </div>
        </div>
        
        <!-- Inventario de marcas -->
        <div class="card shadow-sm">
            <div class="card-header text-white bg-primary text-center">
                <h2><i class="fas fa-clipboard"></i> Inventario de Marcas</h2>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Marca</th>
                            </tr>
                        </thead>
                        <tbody id="tbl_marcas">
                            <%
                                Marca marca = new Marca();
                                DefaultTableModel tabla = marca.leer(); 
                                for (int t = 0; t < tabla.getRowCount(); t++) {
                                    out.println("<tr data-id='" + tabla.getValueAt(t, 0) + "'>");
                                    out.println("<td>" + tabla.getValueAt(t, 0) + "</td>");
                                    out.println("<td>" + tabla.getValueAt(t, 1) + "</td>"); // Asegúrate de mostrar el segundo campo
                                    out.println("</tr>");
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <script>
            // Función para limpiar los campos del formulario de marca
            function limpiar() {
                $("#marca").val(''); // Restablecemos el campo de marca a vacío
                $("#id_marca").val('0'); // Reiniciamos el valor de ID a 0 (si tienes un campo oculto para el ID)
            }

            // Evento de clic en una fila de la tabla de marcas
            $('#tbl_marcas').on('click', 'tr', function () {
                // Capturamos el ID y nombre de la marca desde la fila seleccionada
                var id = $(this).data('id'); // ID de la marca
                var nombre_marca = $(this).find("td").eq(1).text(); // Nombre de la marca en la segunda celda

                // Asignamos los valores al formulario (ajusta según los IDs de tus campos de formulario)
                $("#id_marca").val(id); // Campo de ID oculto para manejar el ID de la marca
                $("#marca").val(nombre_marca); // Campo de texto para el nombre de la marca
            });
            
            function buscar() {
                const searchTerm = document.getElementById('searchField').value.toLowerCase();
                let found = false;

                // Filtrar puestos
                $('#tbl_marcas tr').filter(function() {
                    const isMatch = $(this).text().toLowerCase().indexOf(searchTerm) > -1;
                    $(this).toggle(isMatch);
                    if (isMatch) found = true; // Actualiza found si hay coincidencias
                });

                // Mostrar alerta si no se encontraron resultados
                if (!found) {
                    alert("No se encontraron resultados.");
                }
            }
        </script>
    </body>
</html>
