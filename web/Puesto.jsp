<%-- 
    Document   : Empleado
    Created on : 13/10/2024, 10:25:21 p. m.
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Modelo.Puesto"%>
<%@page import="java.util.HashMap"%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestión de Puestos</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Sección Izquierda: Datos del Puesto -->
                <div class="col-md-3 p-4 bg-light">
                    <div class="card text-center"> <!-- Clase text-center para centrar el contenido -->
                        <div class="card-body">
                            <i class="bi bi-briefcase-fill" style="font-size: 100px; margin-bottom: 25px;"></i> <!-- Ícono de puesto -->
                            <!-- Button trigger for Puesto Nuevo Modal -->
                            <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#modal_puesto" onclick="limpiarPuesto();">
                                Puesto Nuevo
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Sección Derecha: Tabla y búsquedas -->
                <div class="col-md-9 p-4">
                    <h3>Información de Puestos</h3>
                    
                    <!-- Buscador de Puestos -->
                    <div class="form-group">
                        <label for="searchField">Buscar:</label>
                        <input type="text" id="searchField" style="margin-bottom: 20px;" class="form-control" placeholder="Ingresa el puesto a buscar...">
                        <button type="button" class="btn btn-primary mt-2" onclick="buscar()">Buscar</button>
                    </div>

                <div>
                    <!-- Tabla de todos los puestos ingresados -->
                    <h4 class="text-center">Lista de Puestos</h4>
                    <!-- Tabla para mostrar los puestos -->
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre del Puesto</th>
                            </tr>
                        </thead>
                        <tbody id="tbl_puestos">
                            <%
                                Puesto puesto = new Puesto();
                                DefaultTableModel tabla = puesto.leer(); 
                                for (int t = 0; t < tabla.getRowCount(); t++) {
                                    out.println("<tr data-id='" + tabla.getValueAt(t, 0) + "'>");
                                    out.println("<td>" + tabla.getValueAt(t, 0) + "</td>");
                                    out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                                    out.println("</tr>");
                                }
                            %>
                        </tbody>
                    </table>
                    <br/>
                    <br/>
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
        
        

        <!-- Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <script>
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
        </script>
        
        <script>
            function buscar() {
                const searchTerm = document.getElementById('searchField').value.toLowerCase();
                let found = false;

                // Filtrar puestos
                $('#tbl_puestos tr').filter(function() {
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