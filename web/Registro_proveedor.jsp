<%-- 
    Document   : Registro_proveedor
    Created on : 23/10/2024, 7:04:07 p. m.
    Author     : user
--%>

<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page import="Modelo.Proveedores"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
    <title>Proveedores</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
    <div class="container mt-4">
        <h1 class="text-center mb-4">Gestión de Proveedores</h1>

        <!-- Sección de Opciones -->
        <div class="card mb-4">
            <div class="card-header d-flex align-items-center">
                <i class="bi bi-briefcase me-2"></i>
                <span><strong>Proveedores</strong></span>
            </div>
            <div class="card-body d-flex justify-content-between align-items-center">
                <a href="Registro_compras.jsp" class="btn btn-outline-secondary">
                    <i class="bi bi-arrow-left-circle"></i> Regresar a Compras
                </a>
                <div class="d-flex align-items-center">
                    <label for="searchField" class="me-2">Buscar:</label>
                    <input type="text" id="searchField" class="form-control me-6" placeholder="Ingresa el proveedor">
                    <button type="button" class="btn btn-primary" onclick="buscar()">Buscar</button>
                </div>
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modal_proveedor">
                    <i class="bi bi-person-plus-fill"></i> Proveedor Nuevo
                </button>
            </div>
        </div>

        <!-- Modal de Registro/Actualización de Proveedor -->
        <div class="modal fade" id="modal_proveedor" tabindex="-1" aria-labelledby="modalProveedorLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title" id="modalProveedorLabel">Registrar Proveedor</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="sr_cCompras?menu=Proveedores" method="post" class="form-group">
                            <input type="hidden" name="txt_id" id="txt_id" value="0">
                            <div class="mb-3">
                                <label for="txt_proveedor"><b>Proveedor:</b></label>
                                <input type="text" name="txt_proveedor" id="txt_proveedor" class="form-control" placeholder="Nombre del proveedor" required>
                            </div>
                            <div class="mb-3">
                                <label for="txt_nit"><b>NIT:</b></label>
                                <input type="text" name="txt_nit" id="txt_nit" class="form-control" placeholder="Número de NIT" required>
                            </div>
                            <div class="mb-3">
                                <label for="txt_direccion"><b>Dirección:</b></label>
                                <input type="text" name="txt_direccion" id="txt_direccion" class="form-control" placeholder="Dirección del proveedor" required>
                            </div>
                            <div class="mb-3">
                                <label for="txt_telefono"><b>Teléfono:</b></label>
                                <input type="tel" name="txt_telefono" id="txt_telefono" class="form-control" placeholder="Número de teléfono" required>
                            </div>
                            <div class="d-flex justify-content-end">
                                <button name="action" value="agregar" class="btn btn-success me-2"><i class="bi bi-save2-fill"></i> Guardar</button>
                                <button name="action" value="actualizar" class="btn btn-warning me-2"><i class="bi bi-pencil-square"></i> Actualizar</button>
                                <button name="action" value="eliminar" class="btn btn-danger" onclick="return confirm('¿Desea eliminar este proveedor?')"><i class="bi bi-trash-fill"></i> Eliminar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tabla de Proveedores -->
        <div class="card">
            <div class="card-header d-flex align-items-center">
                <i class="bi bi-table me-2"></i>
                <span><strong>Listado de Proveedores</strong></span>
            </div>
            <div class="card-body table-responsive" style="max-height: 300px; overflow-y: auto;">
                <table class="table table-striped table-hover align-middle">
                    <thead class="table-primary sticky-top">
                        <tr>
                            <th>ID</th>
                            <th>Proveedor</th>
                            <th>NIT</th>
                            <th>Dirección</th>
                            <th>Teléfono</th>
                        </tr>
                    </thead>
                    <tbody id="tbl_proveedor">
                        <%
                            Proveedores proveedores = new Proveedores();
                            DefaultTableModel tabla = proveedores.leer();
                            for (int i = 0; i < tabla.getRowCount(); i++) {
                                out.println("<tr data-id='" + tabla.getValueAt(i, 0) + "'>");
                                out.println("<td>" + tabla.getValueAt(i, 0) + "</td>");
                                out.println("<td>" + tabla.getValueAt(i, 1) + "</td>");
                                out.println("<td>" + tabla.getValueAt(i, 2) + "</td>");
                                out.println("<td>" + tabla.getValueAt(i, 3) + "</td>");
                                out.println("<td>" + tabla.getValueAt(i, 4) + "</td>");
                                out.println("</tr>");
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" crossorigin="anonymous"></script>
    <script>
        function limpiar() {
            $("#txt_id").val(0);
            $("#txt_proveedor").val('');
            $("#txt_nit").val('');
            $("#txt_direccion").val('');
            $("#txt_telefono").val('');
        }

        $('#tbl_proveedor').on('click', 'tr', function () {
            var $row = $(this);
            $("#txt_id").val($row.data('id'));
            $("#txt_proveedor").val($row.children('td').eq(1).text());
            $("#txt_nit").val($row.children('td').eq(2).text());
            $("#txt_direccion").val($row.children('td').eq(3).text());
            $("#txt_telefono").val($row.children('td').eq(4).text());
            $('#modal_proveedor').modal('show');
        });
    </script>
    <script>
            function buscar() {
                const searchTerm = document.getElementById('searchField').value.toLowerCase();
                let found = false;

                // Filtrar puestos
                $('#tbl_proveedor tr').filter(function() {
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

