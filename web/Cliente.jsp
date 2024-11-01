<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Modelo.Cliente"%>
<%@page import="javax.swing.table.DefaultTableModel"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestión de Clientes</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Sección Izquierda: Datos del cliente -->
                <div class="col-md-3 p-4 bg-light">
                    <div class="card">
                        <img src="https://i.pinimg.com/originals/c6/96/f8/c696f868fb6ccfcc908b72f07f58089a.jpg" class="card-img-top" alt="Imagen del cliente">
                        <div class="card-body">
                            <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#modal_clientes">
                                Cliente Nuevo
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Sección Derecha: Tabla y búsquedas -->
                <div class="col-md-9 p-4">
                    <h3>Información de Compras</h3>
                    
                    <!-- Buscador de Clientes -->
                    <form method="post" action="sr_controlador?menu=Cliente&accion=buscar">
                        <div class="form-group">
                            <label for="searchField">Buscar:</label>
                            <input type="text" id="searchField" style="margin-bottom: 20px;" class="form-control" placeholder="Ingresa el cliente a buscar...">
                            <button type="button" class="btn btn-primary mt-2" onclick="buscar()">Buscar</button>
                        </div>
                    </form>

                    <!-- Tabla de compras del cliente -->
                    <h4>Compras del Cliente</h4>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Fecha</th>
                                <th>Producto</th>
                                <th>Monto</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>15/08/2023</td>
                                <td>Laptop</td>
                                <td>$1500</td>
                            </tr>
                            <tr>
                                <td>12/07/2023</td>
                                <td>Smartphone</td>
                                <td>$800</td>
                            </tr>
                        </tbody>
                    </table>

                    
                    
                    
                    <!-- Tabla de todos los clientes ingresados -->
                    <h4>Lista de Clientes</h4>
                    <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombres</th>
                        <th>Apellidos</th>
                        <th>Nit</th>
                        <th>Genero</th>
                        <th>Telefono</th>
                        <th>Correo Electronico</th>
                        <th>Fecha Ingreso</th>
                    </tr>
                </thead>
                <tbody id="tbl_clientes">
                    <%
                        Cliente cliente = new Cliente();
                        DefaultTableModel tabla = new DefaultTableModel();
                        tabla = cliente.leer();
                        for (int t = 0; t < tabla.getRowCount(); t++) {
                            out.println("<tr data-id='" + tabla.getValueAt(t, 0) + "'>");
                            out.println("<td>" + tabla.getValueAt(t, 0) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t, 2) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t, 4) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t, 5) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t, 6) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t, 7) + "</td>");
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

                         
        
        <!-- Cliente Nuevo Modal -->
        <div class="modal fade" id="modal_clientes" tabindex="-1" role="dialog" aria-labelledby="modal_clienteLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body">
                        <!-- Formulario de Cliente -->
                        <form action="Controlador?menu=Cliente" method="post" class="form-group">

                            <label for="lbl_id">ID</label>
                            <input type="text" name="txt_id" id="txt_id" class="form-control" value="0" readonly>

                            <label for="lbl_nombres">Nombres</label>
                            <input type="text" name="txt_nombres" id="txt_nombres" class="form-control" placeholder="Primer nombre Segundo nombre" required>

                            <label for="lbl_apellidos">Apellidos</label>
                            <input type="text" name="txt_apellidos" id="txt_apellidos" class="form-control" placeholder="Primer apellido Segundo apellido" required>

                            <label for="lbl_nit">Nit</label>
                            <input type="text" name="txt_nit" id="txt_nit" class="form-control" placeholder="548714" required>

                            <label for="lbl_genero">Género</label>
                            <div>
                                <label>
                                    <input type="radio" name="txt_genero" value="true" required> Masculino
                                </label>
                                <label>
                                    <input type="radio" name="txt_genero" value="false" required> Femenino
                                </label>
                            </div>
                            
                            <label for="lbl_telefono">Teléfono</label>
                            <input type="number" name="txt_telefono" id="txt_telefono" class="form-control" placeholder="58575525" required>

                            <label for="lbl_correo">Correo Electronico</label>
                            <input type="email" name="txt_correo" id="txt_correo" class="form-control" placeholder="example@gmail.com" required>

                            <label for="lbl_fi">Fecha Ingreso</label>
                            <input type="datetime-local" name="txt_fi" id="txt_fi" class="form-control" placeholder="año-mes-dia" required>

                            <br/>

                            <!-- Botones de acción -->
                            <button  name="action" value="agregar" class="btn btn-primary btn-lg">Agregar</button>
                            <button  name="action" value="actualizar" class="btn btn-success btn-lg">Actualizar</button>
                            <button  name="action" value="eliminar" class="btn btn-danger btn-lg" onclick="javascript:if(!confirm('Desea eliminar'))return false">Eliminar</button>
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
            function limpiar(){
                $("#txt_id").val(0);
                $("#txt_nombres").val('');
                $("#txt_apellidos").val('');
                $("#txt_nit").val('');
                $("#txt_genero").val('');
                $("#txt_telefono").val('');
                $("#txt_correo").val('');
                $("#txt_fi").val('');
            }

            $('#tbl_clientes').on('click', 'tr td', function (event) {
                var target, id, nombres, apellidos, nit, genero, telefono, correo, ingreso;
                target = $(event.target);
                id = target.parent().data('id');
                nombres = target.parent("tr").find("td").eq(1).html();
                apellidos = target.parent("tr").find("td").eq(2).html();
                nit = target.parent("tr").find("td").eq(3).html();
                genero = target.parent("tr").find("td").eq(4).html();
                telefono = target.parent("tr").find("td").eq(5).html();
                correo = target.parent("tr").find("td").eq(6).html();
                ingreso = target.parent("tr").find("td").eq(7).html();
                

                $("#txt_id").val(id);
                $("#txt_nombres").val(nombres);
                $("#txt_apellidos").val(apellidos);
                $("#txt_nit").val(nit);
                $("#txt_genero").val(genero);
                $("#txt_telefono").val(telefono);
                $("#txt_correo").val(correo);
                $("#txt_fi").val(ingreso);
                $("#modal_clientes").modal('show');
            });
        </script>
        
        <script>
            function buscar() {
                const searchTerm = document.getElementById('searchField').value.toLowerCase();
                let found = false;

                // Filtrar cliente
                $('#tbl_clientes tr').filter(function() {
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
