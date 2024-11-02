<%@ page import="Modelo.Marca" %>
<%@ page import="Modelo.Producto" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="javax.swing.table.DefaultTableModel" %>

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
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventario de Productos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        body { background-color: #f5f5f5; }
        .card { border-radius: 15px; border: none; }
        .card-header { background: linear-gradient(90deg, #007bff, #0056b3); color: #ffffff; border-radius: 15px 15px 0 0; }
        .table-responsive { border-radius: 15px; overflow: hidden; }
        .table th, .table td { text-align: center; vertical-align: middle; }
        .btn { border-radius: 50px; padding: 10px 20px; }
        .input-group > input { border-radius: 50px 0 0 50px; }
        .input-group > button { border-radius: 0 50px 50px 0; }
        .img-thumbnail { max-width: 200px; }
    </style>
</head>
<body>
    <div class="container mt-5">
        <!-- Formulario para ingresar un nuevo producto -->
        <div class="card shadow-sm mb-5">
            <div class="card-header text-white text-center">
                <h2 class="mb-0"><i class="bi bi-plus-circle"></i> Ingresar Producto</h2>
            </div>
            <div class="card-body">
                <form action="sr_cInventario" method="post" enctype="multipart/form-data" >
                    <div class="row mb-3">
                        <div class="col-md-1">
                            <label for="id" class="form-label">ID</label>
                             <input type="text" class="form-control" id="idProducto" name="idProducto" value="0" readonly>
                        </div>
                        <div class="col-md-5">
                            <label for="producto" class="form-label">Producto</label>
                            <input type="text" class="form-control" id="producto" name="producto" required>
                        </div>
                        <div class="col-md-5">
                            <label for="drop_marca" class="form-label">Marcas</label>
                            <select name="drop_marca" id="drop_marca" class="form-select" required>
                                <%
                                    Marca marca = new Marca();
                                    HashMap<String, String> drop = marca.drop_marca(); 
                                    for (String i : drop.keySet()) {
                                        out.write("<option value='" + i + "'>" + drop.get(i) + "</option>");
                                    }
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-12">
                            <label for="descripcion" class="form-label">Descripción</label>
                            <textarea class="form-control" id="descripcion" name="descripcion" rows="3" required></textarea>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label for="precioCosto" class="form-label">Precio Costo</label>
                            <input type="number" step="0.01" class="form-control" id="precioCosto" name="precioCosto" required>
                        </div>
                        <div class="col-md-4">
                            <label for="precioVenta" class="form-label">Precio Venta</label>
                            <input type="number" step="0.01" class="form-control" id="precioVenta" name="precioVenta" required>
                        </div>
                        <div class="col-md-4">
                            <label for="existencia" class="form-label">Existencia</label>
                            <input type="number" class="form-control" id="existencia" name="existencia" required>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label for="fechaIngreso" class="form-label">Fecha de Ingreso</label>
                            <input type="datetime-local" class="form-control" id="fechaIngreso" name="fechaIngreso" required>
                        </div>
                        <div class="col-md-6">
                            <label for="imagen" class="form-label">Imagen del Producto</label>
                            <input type="file" class="form-control" id="imagen" name="imagen" accept="image/*">
                            <img id="previewImagen" src="" alt="Previsualización de la Imagen" class="img-thumbnail mt-2" style="display: none;">
                        </div>
                    </div>
                    <div class="text-center">
                        <!-- Botones de acción -->
                        <button type="submit" name="accion" value="agregar" class="btn btn-primary btn-lg"><i class="bi bi-plus-circle"></i> Agregar</button>
                        <button type="submit" name="accion" value="actualizar" class="btn btn-success btn-lg"><i class="bi bi-pencil"></i> Actualizar</button>
                        <button type="submit" name="accion" value="eliminar" class="btn btn-danger btn-lg" onclick="javascript:if(!confirm('¿Desea eliminar?'))return false"><i class="bi bi-trash"></i> Eliminar</button>
                        <button type="button" class="btn btn-warning btn-lg" onclick="limpiar()"><i class="bi bi-x-circle"></i> Cancelar</button>
                        <a href="Marcas.jsp" class="btn btn-secondary btn-lg"><i class="bi bi-tags"></i> Marcas</a>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- Buscador de marcas -->
        <div class="form-group mb-3">
            <label for="searchField"><i class="bi bi-search"></i> Buscar:</label>
            <div class="input-group">
                <input type="text" id="searchField" class="form-control" placeholder="Ingresa la marca a buscar...">
                <button type="button" class="btn btn-primary" onclick="buscar()"><i class="bi bi-search"></i> Buscar</button>
            </div>
        </div>
                            
        <!-- Inventario de productos -->
        <div class="card shadow-sm">
            <div class="card-header text-white text-center">
                <h2 class="mb-0"><i class="bi bi-box"></i> Inventario de Productos</h2>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead class="table-info">
                            <tr>
                                <th>ID</th>
                                <th>Producto</th>
                                <th>Marca</th>
                                <th>Descripción</th>
                                <th>Imagen</th>
                                <th>Precio Costo</th>
                                <th>Precio Venta</th>
                                <th>Existencia</th>
                                <th>Fecha de Ingreso</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody id="tbl_producto">
                            <%
                                Producto producto = new Producto();
                                DefaultTableModel tabla = producto.leer();
                                for (int t = 0; t < tabla.getRowCount(); t++) {
                                    out.println("<tr data-id='" + tabla.getValueAt(t, 0) + "'>");
                                    out.println("<td>" + tabla.getValueAt(t, 0) + "</td>");
                                    out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                                    out.println("<td>" + tabla.getValueAt(t, 2) + "</td>");
                                    out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
                                    out.println("<td><img src='" + tabla.getValueAt(t, 4) + "' alt='Imagen' class='img-fluid' style='max-width: 100px;'></td>");
                                    out.println("<td>" + tabla.getValueAt(t, 5) + "</td>");
                                    out.println("<td>" + tabla.getValueAt(t, 6) + "</td>");
                                    out.println("<td>" + tabla.getValueAt(t, 7) + "</td>");
                                    out.println("<td>" + tabla.getValueAt(t, 8) + "</td>");
                                    out.println("<td><button class='btn btn-warning' onclick='editarProducto(this)'><i class='bi bi-pencil'></i> Editar</button></td>");
                                    out.println("</tr>");
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
                        
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <script>
            // Función para limpiar los campos del formulario de productos
            function limpiar() {
                $("#idProducto").val('');
                $("#producto").val('');
                $("#drop_marca").val('');
                $("#descripcion").val('');
                $("#precioCosto").val('');
                $("#precioVenta").val('');
                $("#existencia").val('');
                $("#fechaIngreso").val('');
                $("#imagen").val(''); // Restablecer el campo de imagen
                $('#previewImagen').hide(); // Ocultar la previsualización de imagen
            }

    
            // Evento para manejar clics en las filas de la tabla de productos
            $('#tbl_producto').on('click', 'tr', function () {
                var id, producto, marca, descripcion, precioCosto, precioVenta, existencia, fechaIngreso, imagenURL;

                // Obtener los valores de cada celda de la fila seleccionada
                id = $(this).find('td:eq(0)').text();
                producto = $(this).find('td:eq(1)').text();
                marca = $(this).find('td:eq(2)').text();
                descripcion = $(this).find('td:eq(3)').text();
                imagenURL = $(this).find('td:eq(4) img').attr('src'); // Obtener el atributo src de la imagen
                precioCosto = $(this).find('td:eq(5)').text();
                precioVenta = $(this).find('td:eq(6)').text();
                existencia = $(this).find('td:eq(7)').text();
                fechaIngreso = $(this).find('td:eq(8)').text();

                // Asignar los datos a los campos del formulario de productos
                $('#idProducto').val(id);
                $('#producto').val(producto);
                $('#descripcion').val(descripcion);
                $('#precioCosto').val(precioCosto);
                $('#precioVenta').val(precioVenta);
                $('#existencia').val(existencia);
                $('#fechaIngreso').val(fechaIngreso);

                // Mostrar la imagen en la previsualización si hay una URL
                if (imagenURL) {
                    $('#previewImagen').attr('src', imagenURL).show();
                } else {
                    $('#previewImagen').hide();
                }

                // Seleccionar la marca usando el texto de la opción si la marca es el nombre visible
                $("#drop_marca option").filter(function() {
                    return $(this).text() === marca;  // Filtrar opciones basándose en el texto visible
                }).prop("selected", true);
            });

            // Guardar la posición del scroll
            function saveScrollPosition() {
                sessionStorage.setItem("scrollPosition", window.scrollY);
            }

            // Restaurar la posición del scroll al cargar la página
            window.onload = function() {
                if (sessionStorage.getItem("scrollPosition")) {
                    window.scrollTo(0, sessionStorage.getItem("scrollPosition"));
                }
            }
            
            function buscar() {
                const searchTerm = document.getElementById('searchField').value.toLowerCase();
                let found = false;

                // Filtrar puestos
                $('#tbl_producto tr').filter(function() {
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
