<%-- 
    Document   : Empleado
    Created on : 13/10/2024, 10:25:21 p. m.
    Author     : DELL
--%>
<%@page import="Modelo.Puesto"%>
<%@page import="Modelo.Empleado"%>
<%@page import="Modelo.Usuario"%>
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
        <div class="container">
        <!-- Card for Modals -->
        <div class="form-group">
            <div class="card">
                <div class="card-header text-white" style="background-color: #90b4ce">
                    <h2>Panel de Control del Personal</h2>
                </div>
                <div class="card-body">
                    <!-- Button trigger for Empleado Nuevo Modal -->
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modal_empleado" onclick="limpiarEmpleado();">
                        Empleado Nuevo
                    </button>
                    
                    <!-- Button trigger for Puesto Nuevo Modal -->
                    <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#modal_puesto" onclick="limpiarPuesto();">
                        Puesto Nuevo
                    </button>
                    <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modal_usuario" onclick="limpiarUsuario();">
                        Usuario Nuevo
                    </button>
                    <div class="form-group">
                        <label for="searchField">Buscar:</label>
                        <input type="text" id="searchField" style="margin-bottom: 20px;" class="form-control" placeholder="Ejemplo: tabla empleados, nombre empleado...">
                        <button type="button" class="btn btn-primary mt-2" onclick="buscar()">Buscar</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Empleado Nuevo Modal -->
        <div class="modal fade" id="modal_empleado" tabindex="-1" role="dialog" aria-labelledby="modal_empleadoLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body">
                        <!-- Formulario de Empleado -->
                        <form action="Controlador?menu=Empleado" method="post" class="form-group">
                            <div class="card-header text-center">
                                <h3>Control de Empleados</h3>
                            </div>
                            <label for="lbl_id">ID</label>
                            <input type="text" name="txt_id" id="txt_id" class="form-control" value="0" readonly>

                            <label for="lbl_nombres">Nombres</label>
                            <input type="text" name="txt_nombres" id="txt_nombres" class="form-control" placeholder="Primer nombre Segundo nombre" required>

                            <label for="lbl_apellidos">Apellidos</label>
                            <input type="text" name="txt_apellidos" id="txt_apellidos" class="form-control" placeholder="Primer apellido Segundo apellido" required>

                            <label for="lbl_direccion">Dirección</label>
                            <input type="text" name="txt_direccion" id="txt_direccion" class="form-control" placeholder="Guatemala" required>

                            <label for="lbl_telefono">Teléfono</label>
                            <input type="number" name="txt_telefono" id="txt_telefono" class="form-control" placeholder="12345678" required>

                            <label for="lbl_dpi">DPI</label>
                            <input type="number" name="txt_dpi" id="txt_dpi" class="form-control" placeholder="3027405800101" required>

                            <label for="lbl_genero">Género</label>
                            <div>
                                <label>
                                    <input type="radio" name="txt_genero" value="true" required> Masculino
                                </label>
                                <label>
                                    <input type="radio" name="txt_genero" value="false" required> Femenino
                                </label>
                            </div>

                            <label for="lbl_fn">Nacimiento</label>
                            <input type="date" name="txt_fn" id="txt_fn" class="form-control" required>

                            <label for="lbl_puesto">Puesto</label>
                            <select name="drop_puesto" id="drop_puesto" class="form-control">
                                <%
                                    Puesto puesto = new Puesto();
                                    HashMap<String, String> drop = puesto.drop_puesto();
                                    for (String i : drop.keySet()) {
                                        out.write("<option value='" + i + "'>" + drop.get(i) + "</option>");
                                    }
                                %>
                            </select>

                            <br/>

                            <label for="lbl_fl">Inicio Laboral</label>
                            <input type="date" name="txt_fl" id="txt_fl" class="form-control" required>

                            <label for="lbl_fi">Fecha Ingreso</label>
                            <input type="datetime-local" name="txt_fi" id="txt_fi" class="form-control" required>

                            <br/>

                            <!-- Botones de acción -->
                            <button  name="action" id="btn_agregarE" value="agregarE" class="btn btn-primary btn-lg">Agregar</button>
                            <button  name="action" id="btn_actualizarE" value="actualizarE" class="btn btn-success btn-lg">Actualizar</button>
                            <button  name="action" id="btn_eliminarE" value="eliminarE" class="btn btn-danger btn-lg" onclick="javascript:if(!confirm('Desea eliminar'))return false">Eliminar</button>
                            <button type="button" class="btn btn-warning btn-lg" data-bs-dismiss="modal">Cerrar</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <!-- Puesto Nuevo Modal -->
        <div class="modal fade" id="modal_puesto" tabindex="-1" role="dialog" aria-labelledby="modal_puesto" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body">
                        <form action="Controlador?menu=Puesto" method="post" class="form-group">
                            <div class="card-header text-center">
                                <h3>Control de Puestos</h3>
                            </div>
                            <label for="lbl_id_puesto">ID</label>
                            <input type="text" name="txt_id_puesto" id="txt_id_puesto" class="form-control" value="0" readonly>
                            <label for="lbl_nombre_puesto">Nombre del Puesto</label>
                            <input type="text" name="txt_nombre_puesto" id="txt_nombre_puesto" class="form-control" required placeholder="Ingrese el nombre del puesto">
                            <br/>
                            <button type="submit" name="action" id="btn_agregarP" value="agregarP" class="btn btn-primary btn-lg">Agregar</button>
                            <button type="submit" name="action" id="btn_actualizarP" value="actualizarP" class="btn btn-success btn-lg">Actualizar</button>
                            <button type="submit" name="action" id="btn_eliminarP" value="eliminarP" class="btn btn-danger btn-lg" onclick="javascript:if(!confirm('Desea eliminar'))return false">Eliminar</button>
                            <button type="button" class="btn btn-warning btn-lg" data-bs-dismiss="modal">Cerrar</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
              
        <!-- Usuario Nuevo Modal -->
            <div class="modal fade" id="modal_usuario" tabindex="-1" role="dialog" aria-labelledby="modal_usuario" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-body">
                            <form action="Controlador?menu=Usuario" method="post" class="form-group">
                                <div class="card-header text-center">
                                    <h3>Control de Usuarios</h3>
                                </div>
                                <label for="lbl_id_usuario">ID</label>
                                <input type="text" name="txt_id_usuario" id="txt_id_usuario" class="form-control" value="0" readonly>

                                <label for="lbl_nombre_usuario">Nombre de Usuario</label>
                                <input type="text" name="txt_nombre_usuario" id="txt_nombre_usuario" class="form-control" required placeholder="Ingrese el nombre de usuario">

                                <label for="lbl_contraseña">Contraseña</label>
                                <input type="password" name="txt_contraseña" id="txt_contraseña" class="form-control" required placeholder="Ingrese la contraseña">

                                <label for="lbl_rol">Rol</label>
                                <select name="drop_puestoU" id="drop_puestoU" class="form-control">
                                    <%
                                        Puesto puestoU = new Puesto();
                                        HashMap<String, String> dropU = puesto.drop_puesto();
                                        for (String i : drop.keySet()) {
                                            out.write("<option value='" + i + "'>" + drop.get(i) + "</option>");
                                        }
                                    %>
                                </select>
                                <br/>
                                <button name="action" id="btn_agregarU" value="agregarU" class="btn btn-primary btn-lg">Agregar</button>
                                <button name="action" id="btn_actualizarU" value="actualizarU" class="btn btn-success btn-lg">Actualizar</button>
                                <button name="action" id="btn_eliminarU" value="eliminarU" class="btn btn-danger btn-lg" onclick="javascript:if(!confirm('¿Desea eliminar?'))return false">Eliminar</button>
                                <button type="button" class="btn btn-warning btn-lg" data-bs-dismiss="modal">Cerrar</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
          

            <table class="table table-striped table-hover">
                <thead>
                    <div class="card-header text-center">
                        <h2>Datos personales y laborales de los Empleados</h2>
                    </div>
                    <tr>
                        <th>ID</th>
                        <th>Nombres</th>
                        <th>Apellidos</th>
                        <th>Direccion</th>
                        <th>Telefono</th>
                        <th>DPI</th>
                        <th>Genero</th>
                        <th>Nacimiento</th>
                        <th>Puesto</th>
                        <th>Inicio Laboral</th>
                        <th>Fecha Ingreso</th>
                    </tr>
                </thead>
                <tbody id="tbl_empleados">
                    <%
                        Empleado empleado = new Empleado();
                        DefaultTableModel tabla = new DefaultTableModel();
                        tabla = empleado.leer();
                        for (int t = 0; t < tabla.getRowCount(); t++) {
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
            <br/>
            <br/>
                
            <!-- Tabla para mostrar los puestos -->
            <table class="table table-striped table-hover">
                <thead>
                    <div class="card-header text-center">
                        <h2>Clasificación de Puestos</h2>
                    </div>
                    <tr>
                        <th>ID</th>
                        <th>Nombre del Puesto</th>
                    </tr>
                </thead>
                <tbody id="tbl_puestos">
                    <%
                        DefaultTableModel tablaP = puesto.leer(); 
                        for (int t = 0; t < tablaP.getRowCount(); t++) {
                            out.println("<tr data-id='" + tablaP.getValueAt(t, 0) + "'>");
                            out.println("<td>" + tablaP.getValueAt(t, 0) + "</td>");
                            out.println("<td>" + tablaP.getValueAt(t, 1) + "</td>");
                            out.println("</tr>");
                        }
                    %>
                </tbody>
            </table>
            <br/>
            <br/>
            
            
            
            <!-- Tabla para mostrar los usuarios -->
            <table class="table table-striped table-hover">
                <thead>
                    <div class="card-header text-center">
                        <h2>Clasificación de Usuarios</h2>
                    </div>
                    <tr>
                        <th>ID</th>
                        <th>Nombre de Usuario</th>
                        <th>Contraseña</th>
                        <th>Rol</th>
                    </tr>
                </thead>
                <tbody id="tbl_usuarios">
                    <%
                        Usuario usuario = new Usuario();
                        DefaultTableModel tablaU = usuario.leer(); // Obtener el modelo de la tabla
                        for (int t = 0; t < tablaU.getRowCount(); t++) {
                            out.println("<tr data-id='" + tablaU.getValueAt(t, 0) + "'>");
                            out.println("<td>" + tablaU.getValueAt(t, 0) + "</td>");
                            out.println("<td>" + tablaU.getValueAt(t, 1) + "</td>");
                            out.println("<td>" + tablaU.getValueAt(t, 2) + "</td>");
                            out.println("<td>" + tablaU.getValueAt(t, 3) + "</td>");
                            out.println("</tr>");
                        }
                    %>
                </tbody>
            </table>
            <br/>

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
                    $("input[name='txt_genero']").prop('checked', false); // Limpiar radio buttons
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
                if (genero === 'Masculino') {
                    $("input[name='txt_genero'][value='true']").prop('checked', true);
                } else {
                    $("input[name='txt_genero'][value='false']").prop('checked', true);
                }
                $('#txt_fn').val(nacimiento);
                $('#drop_puesto').val(puesto);
                $('#txt_fl').val(inicio_laboral);
                $('#txt_fi').val(fecha_ingreso);

                // Abrir el modal de empleado
                var modal = new bootstrap.Modal(document.getElementById("modal_empleado"));
                modal.show();
            });

            function limpiarPuesto() {
                $("#txt_nombre_puesto").val('');
                $("#txt_id_puesto").val('0'); // Reseteamos a 0 al limpiar
                $("#modal_puesto").val('');
            }

            $('#tbl_puestos').on('click', 'tr', function () {
                // Capturamos el ID de la fila que se ha clicado
                var id = $(this).data('id'); // Obtener el ID de la fila
                var nombre_puesto = $(this).find("td").eq(1).text(); // Obtener el nombre del puesto de la segunda celda

                // Asignamos los valores a los inputs del modal
                $("#txt_id_puesto").val(id);
                $("#txt_nombre_puesto").val(nombre_puesto);

                // Abrimos el modal
                var modal = new bootstrap.Modal(document.getElementById("modal_puesto"));
                modal.show();
            });
            
            // Limpiar campos y abrir modal de usuario
            function limpiarUsuario() {
                $("#txt_nombre_usuario").val('');
                $("#txt_id_usuario").val('0');
                $("#txt_contraseña").val('');
                $("#txt_rol").val('');
                $("#drop_puestoU").val('0');
            }

            $('#tbl_usuarios').on('click', 'tr', function () {
                // Capturamos el ID de la fila que se ha clicado
                var id = $(this).data('id'); // Obtener el ID de la fila
                var nombre_usuario = $(this).find("td").eq(1).text();
                var contraseña = $(this).find("td").eq(2).text();
                var rol = $(this).find("td").eq(3).text();

                // Asignamos los valores a los inputs del modal
                $("#txt_id_usuario").val(id); // Asegúrate de usar el ID correcto
                $("#txt_nombre_usuario").val(nombre_usuario); // Establecemos el nombre
                $("#txt_contraseña").val(contraseña); // Establecemos la contraseña
                $("#drop_puestoU").val(rol); // Establecemos el rol

                // Abrimos el modal
                var modal = new bootstrap.Modal(document.getElementById("modal_usuario"));
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

                // Filtrar puestos
                $('#tbl_puestos tr').filter(function() {
                    const isMatch = $(this).text().toLowerCase().indexOf(searchTerm) > -1;
                    $(this).toggle(isMatch);
                    if (isMatch) found = true; // Actualiza found si hay coincidencias
                });

                // Filtrar usuarios
                $('#tbl_usuarios tr').filter(function() {
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