<%-- 
    Document   : Empleado
    Created on : 13/10/2024, 10:25:21 p. m.
    Author     : DELL
--%>
<%@page import="Modelo.Puesto"%>
<%@page import="Modelo.Empleado"%>
<%@page import="java.util.HashMap"%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Empleados</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    </head>
    <body>
        <div class="container mt-4" style="max-width: 1200px;">
            <!-- Panel de Control -->
            <div class="card shadow-lg">
                <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                    <h3 class="mb-0"><i class="bi bi-people-fill me-2"></i> Panel de Control del Personal</h3>
                    <button type="button" class="btn btn-light" data-bs-toggle="modal" data-bs-target="#modal_empleado" onclick="limpiarEmpleado();">
                        <i class="bi bi-person-plus-fill"></i> Empleado Nuevo
                    </button>
                </div>
                <div class="card-body">
                    <!-- Buscador de empleados y botón de acceso a Puestos -->
                    <div class="d-flex align-items-center mb-4">
                        <a href="Puesto.jsp" class="btn btn-secondary me-3"><i class="bi bi-briefcase-fill"></i> Puestos</a>
                        <a href="Registro_venta.jsp" class="btn btn-secondary me-3"><i class="bi bi-briefcase-fill"></i> Venta Nueva</a>
                        <div class="input-group ms-auto" style="width: 300px;">
                            <span class="input-group-text"><i class="bi bi-search"></i></span>
                            <input type="text" id="searchField" class="form-control" placeholder="Buscar empleado..." aria-label="Buscar empleado">
                            <button class="btn btn-primary" onclick="buscar()"><i class="bi bi-search"></i></button>
                        </div>
                    </div>
                    
                    <!-- Tabla de Empleados -->
                    <div class="table-responsive">
                        <table class="table table-striped table-hover custom-table">
                            <thead class="table-primary">
                                <tr class="text-center">
                                    <th>ID</th><th>Nombres</th><th>Apellidos</th><th>Dirección</th><th>Teléfono</th>
                                    <th>DPI</th><th>Género</th><th>Nacimiento</th><th>Puesto</th>
                                    <th>Inicio Laboral</th><th>Fecha Ingreso</th>
                                </tr>
                            </thead>
                            <tbody id="tbl_empleados" style="font-size: 13px;">
                                <%
                                    Empleado empleado = new Empleado();
                                    DefaultTableModel tabla = new DefaultTableModel();
                                    tabla = empleado.leer();
                                    for (int t = 0; t < tabla.getRowCount(); t++) {
                                        out.println("<tr>");
                                        out.println("<td>" + tabla.getValueAt(t, 0) + "</td>");
                                        out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                                        out.println("<td>" + tabla.getValueAt(t, 2) + "</td>");
                                        out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
                                        out.println("<td>" + tabla.getValueAt(t, 4) + "</td>");
                                        out.println("<td>" + tabla.getValueAt(t, 5) + "</td>");
                                        out.println("<td>" + tabla.getValueAt(t, 6) + "</td>");
                                        out.println("<td>" + tabla.getValueAt(t, 7) + "</td>");
                                        out.println("<td>" + tabla.getValueAt(t, 8) + "</td>");
                                        out.println("<td>" + tabla.getValueAt(t, 9) + "</td>");
                                        out.println("<td>" + tabla.getValueAt(t, 10) + "</td>");
                                        out.println("</tr>");
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Modal de Empleado -->
            <div class="modal fade" id="modal_empleado" tabindex="-1" aria-labelledby="modal_empleadoLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header bg-primary text-white">
                            <h5 class="modal-title" id="modal_empleadoLabel"><i class="bi bi-person-badge-fill"></i> Gestión de Empleados</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="Controlador?menu=Empleado" method="post" class="form-group">
                                <input type="hidden" name="txt_id" id="txt_id" value="0">
                                
                                <!-- Campos del Formulario -->
                                <div class="mb-3">
                                    <label for="txt_nombres" class="form-label">Nombres</label>
                                    <input type="text" name="txt_nombres" id="txt_nombres" class="form-control" placeholder="Ej. Juan Pedro" required>
                                </div>
                                <div class="mb-3">
                                    <label for="txt_apellidos" class="form-label">Apellidos</label>
                                    <input type="text" name="txt_apellidos" id="txt_apellidos" class="form-control" placeholder="Ej. González Rojas" required>
                                </div>
                                <!-- Dirección, Teléfono, DPI -->
                                <div class="mb-3">
                                    <label for="txt_direccion" class="form-label">Dirección</label>
                                    <input type="text" name="txt_direccion" id="txt_direccion" class="form-control" placeholder="Ej. Guatemala" required>
                                </div>
                                <div class="mb-3">
                                    <label for="txt_telefono" class="form-label">Teléfono</label>
                                    <input type="number" name="txt_telefono" id="txt_telefono" class="form-control" placeholder="Ej. 12345678" required>
                                </div>
                                <div class="mb-3">
                                    <label for="txt_dpi" class="form-label">DPI</label>
                                    <input type="number" name="txt_dpi" id="txt_dpi" class="form-control" placeholder="Ej. 3027405800101" required>
                                </div>
                                
                                <!-- Género, Nacimiento, Puesto -->
                                <div class="mb-3">
                                    <label for="txt_genero" class="form-label">Género</label>
                                    <select name="txt_genero" id="txt_genero" class="form-select" required>
                                        <option value="" selected>Seleccione género</option>
                                        <option value="M">Masculino</option>
                                        <option value="F">Femenino</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="txt_fn" class="form-label">Fecha de Nacimiento</label>
                                    <input type="date" name="txt_fn" id="txt_fn" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label for="drop_puesto" class="form-label">Puesto</label>
                                    <select name="drop_puesto" id="drop_puesto" class="form-select" required>
                                        <%
                                            Puesto puesto = new Puesto();
                                            HashMap<String, String> drop = puesto.drop_puesto();
                                            for (String i : drop.keySet()) {
                                                out.write("<option value='" + i + "'>" + drop.get(i) + "</option>");
                                            }
                                        %>
                                    </select>
                                </div>
                                     <br/>
                                <div class="mb-3">
                                    <label for="lbl_fl">Inicio Laboral</label>
                                    <input type="date" name="txt_fl" id="txt_fl" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label for="lbl_fi">Fecha Ingreso</label>
                                    <input type="datetime-local" name="txt_fi" id="txt_fi" class="form-control" required>
                                </div>
                                <br/>

                                <!-- Botones de Acción -->
                                <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                    <button type="submit" name="action" value="agregarE" class="btn btn-primary"><i class="bi bi-save-fill"></i> Guardar</button>
                                    <button type="submit" name="action" value="actualizarE" class="btn btn-success"><i class="bi bi-arrow-repeat"></i> Actualizar</button>
                                    <button type="submit" name="action" value="eliminarE" class="btn btn-danger" onclick="return confirm('¿Desea eliminar este empleado?');"><i class="bi bi-trash-fill"></i> Eliminar</button>
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"><i class="bi bi-x-lg"></i> Cerrar</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <script>
                function limpiarEmpleado() {
                    $("#txt_id").val(0);
                    $("#txt_nombres").val('');
                    $("#txt_apellidos").val('');
                    $("#txt_direccion").val('');
                    $("#txt_telefono").val('');
                    $("#txt_dpi").val('');
                    $("input[name='txt_genero']").prop('checked', false); 
                    $("#txt_fn").val('');
                    $("#drop_puesto").val(1);
                    $("#txt_fl").val('');
                    $("#txt_fi").val('');
                }


               // Evento para manejar clics en las filas de la tabla
            $('#tbl_empleados').on('click', 'tr', function () {
                // Obtener los datos de la fila seleccionada
                var target, id, nombres, apellidos, direccion, telefono, dpi, genero,nacimiento, puesto, inicio_laboral, fecha_ingreso;
                id = $(this).find('td:eq(0)').text();
                nombres = $(this).find('td:eq(1)').text();
                apellidos = $(this).find('td:eq(2)').text();
                direccion = $(this).find('td:eq(3)').text();
                telefono = $(this).find('td:eq(4)').text();
                dpi = $(this).find('td:eq(5)').text();
                genero = $(this).find('td:eq(6)').text();
                nacimiento = $(this).find('td:eq(7)').text();
                puesto = $(this).find('td:eq(8)').text();
                inicio_laboral = $(this).find('td:eq(9)').text();
                fecha_ingreso = $(this).find('td:eq(10)').text();

                // Asignar los datos a los campos del formulario del modal
                $('#txt_id').val(id);
                $('#txt_nombres').val(nombres);
                $('#txt_apellidos').val(apellidos);
                $('#txt_direccion').val(direccion);
                $('#txt_telefono').val(telefono);
                $('#txt_dpi').val(dpi);
                $('#txt_genero').val(genero);
                $('#txt_fn').val(nacimiento); 
                $('#txt_fl').val(inicio_laboral);
                $('#txt_fi').val(fecha_ingreso);
                
                $('#drop_puesto option').each(function() {
                    if ($(this).text() === puesto) { // Comparar el nombre del puesto
                        $('#drop_puesto').val($(this).val()); // Asignar el valor del ID correspondiente
                        return false; // Salir del bucle
                    }
                });

                // Abrir el modal de empleado
                var modal = new bootstrap.Modal(document.getElementById("modal_empleado"));
                modal.show();
            });
        </script>
        
        <script>
            function buscar() {
                const searchTerm = document.getElementById('searchField').value.toLowerCase();
                let found = false;

                // Filtrar empleados
                $('#tbl_empleados tr').filter(function() {
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