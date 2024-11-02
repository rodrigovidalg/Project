<%-- 
    Document   : Registro_compra
    Created on : 13/10/2024, 10:33:01 p. m.
    Author     : DELL
--%>
<%@page import="Modelo.Compras"%>
<%@page import="Modelo.Proveedores"%>
<%@page import="Modelo.Producto"%>
<%@page import="java.util.HashMap"%>
<%@page import="javax.swing.table.DefaultTableModel"%>
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
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">

    </head>
    <body>
<div class="p-4 mb-4 bg-primary text-white rounded d-flex justify-content-between align-items-center">
    <h1 class="m-0"><i class="bi bi-cart4 me-2"></i>Gestión de Compras</h1>
    <div class="d-flex">
        <button type="button" class="btn btn-light me-2" data-bs-toggle="modal" data-bs-target="#modal_nueva_compra" onclick="limpiar()">
            <i class="bi bi-plus-circle me-2"></i>Compra Nueva
        </button>
        <a href="Registro_proveedor.jsp" class="btn btn-light">
            <i class="bi bi-person-fill me-2"></i>Proveedores
        </a>
    </div>
</div>
        <div class="modal fade" id="modal_nueva_compra" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="sr_cCompras?menu=Nueva_compra" method="post">
                            <!-- ID de Compra -->
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="txt_id_compra"><b>ID de Compra:</b></label>
                                    <input type="text" name="txt_id_compra" id="txt_id_compra" class="form-control" value="" readonly>
                                </div>
                                <div class="col-md-6">
                                    <label for="txt_noc"><b>Número de Orden de Compra:</b></label>
                                    <input type="text" name="txt_noc" id="txt_noc" class="form-control" value="" readonly>
                                </div>
                            </div>

                            <!-- Proveedor -->
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="txt_id_proveedor"><b>Proveedor:</b></label> 
                                    <select name="txt_id_proveedor" id="txt_id_proveedor" class="form-control" required>
                                        <% 
                                            Proveedores proveedores = new Proveedores();
                                            DefaultTableModel tablaProveedores = proveedores.leer();
                                            for (int t = 0; t < tablaProveedores.getRowCount(); t++) {
                                                out.println("<option value='" + tablaProveedores.getValueAt(t, 0) + "'>" + tablaProveedores.getValueAt(t, 1) + "</option>");
                                            }
                                        %>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="txt_fecha_orden"><b>Fecha de Orden:</b></label>
                                    <input type="date" name="txt_fecha_orden" id="txt_fecha_orden" class="form-control" required>
                                </div>
                            </div>

                            <!-- Fecha de Ingreso -->
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="txt_fecha_ingreso"><b>Fecha de Ingreso:</b></label>
                                    <input type="datetime-local" name="txt_fecha_ingreso" id="txt_fecha_ingreso" class="form-control" required>
                                </div>
                            </div>

                            <!-- Detalles de Productos -->
                            <h5 class="p-2 bg-light rounded">Detalle de la Compra</h5>
                            <div id="detalles_productos">
                                <!-- Aquí se agregarán dinámicamente los productos -->
                                <div class='row mb-3 producto-row'>
                                    <div class='col-md-4'>
                                        <label for='id_producto'><b>Producto:</b></label>
                                        <select name='id_producto[]' class='form-control' id="selectProductos" required>
                                            <% 
                                                Producto productos = new Producto();
                                                DefaultTableModel tablaProductos = productos.leer();
                                                for (int t = 0; t < tablaProductos.getRowCount(); t++) {
                                                    out.println("<option value='" + tablaProductos.getValueAt(t, 0) + "'>" + tablaProductos.getValueAt(t, 1) + "</option>");
                                                }
                                            %>
                                        </select>
                                    </div>
                                    <div class='col-md-4'>
                                        <label for='cantidad'><b>Cantidad:</b></label>
                                        <input type='number' name='cantidad[]' min='1' class='form-control' id="txt_cantidad" required/>
                                    </div>
                                    <div class='col-md-4'>
                                        <label for='precio_unitario'><b>Precio Unitario:</b></label>
                                        <input type='number' step='.01' name='precio_costo_unitario[]' class='form-control' id="txt_precio_unitario" required/>
                                    </div>
                                </div>
                            </div>

                            <!-- Acciones -->
                            <div class='row mt-3'>
                                <div class='col-md-4'>
                                    <button name='action' value='agregar' class='btn btn-outline-success w-100'><i class="bi bi-plus-circle"></i> Agregar</button>
                                </div>
                                <div class='col-md-4'>
                                    <button name='action' value='actualizar' class='btn btn-outline-warning w-100'><i class="bi bi-pencil-square"></i> Modificar</button>
                                </div>
                                <div class='col-md-4'>
                                    <button name='action' value='eliminar'
                                            onclick='javascript:if(!confirm("¿Desea Eliminar?"))return false'
                                            class='btn btn-outline-danger w-100'><i class="bi bi-trash-fill"></i> Eliminar</button>
                                </div>
                            </div>

                        </form>
                    </div>
                    <div class='modal-footer'>
                        <button type='button' class='btn btn-secondary' data-bs-dismiss='modal'>Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
    <div class="input-group mb-3 p-4">
        <input type="text" id="searchField" class="form-control" placeholder="Buscar proveedor..." onkeyup="buscar()">
        <button class="btn btn-outline-primary" type="button" onclick="buscar()">
            <i class="bi bi-search"></i> Buscar
        </button>
    </div>

        <div class="table-responsive" style="max-height: 300px; overflow-y: auto;">
            <table class="table table-striped table-hover">
                <thead style="position: sticky; top: 0; background-color: white; z-index: 1;">
                    <tr>
                        <th>ID Compra</th>
                        <th>Número de Orden</th>
                        <th>Proveedor</th>
                        <th>Fecha de Orden</th>
                        <th>Fecha de Ingreso</th>
                        <th>Producto</th>
                        <th>Cantidad</th>
                        <th>Precio Unitario</th>
                    </tr>
                </thead>
                <tbody id="tbl_compras">
                    <%
                        Compras compras = new Compras();
                        DefaultTableModel tablaCompras = compras.leer();
                        for (int t = 0; t < tablaCompras.getRowCount(); t++) {
                            out.println("<tr data-id='" + tablaCompras.getValueAt(t, 0) + "' data-id_p='" + tablaCompras.getValueAt(t, 5) + "' data-id_producto='" + tablaCompras.getValueAt(t, 6) + "'>");
                            out.println("<td>" + tablaCompras.getValueAt(t, 0) + "</td>"); // ID Compra
                            out.println("<td>" + tablaCompras.getValueAt(t, 1) + "</td>"); // Número de Orden
                            out.println("<td>" + tablaCompras.getValueAt(t, 4) + "</td>"); // Proveedor
                            out.println("<td>" + tablaCompras.getValueAt(t, 2) + "</td>"); // Fecha de Orden
                            out.println("<td>" + tablaCompras.getValueAt(t, 3) + "</td>"); // Fecha de Ingreso
                            out.println("<td>" + tablaCompras.getValueAt(t, 7) + "</td>"); // producto
                            out.println("<td>" + tablaCompras.getValueAt(t, 8) + "</td>"); // cantidad
                            out.println("<td>" + tablaCompras.getValueAt(t, 9) + "</td>"); // precio_costo_unitario

                            out.println("</tr>");
                        }
                    %>
                </tbody>
            </table>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <script>
            
       function limpiar() {    
     $("#selectProductos").val(1);    
    $("#txt_cantidad").val('');    
    $("#txt_precio_unitario").val('');  
    $("#txt_id_compra").val('');    
    $("#txt_noc").val('');    
    $("#txt_fecha_orden").val('');    
    $("#txt_fecha_ingreso").val('');    
    $("#txt_id_proveedor").val(1);
}

$('#tbl_compras').on('click', 'tr', function (event) {
    var target, id_compra, numeroOrden, id_proveedor, fechaOrden, fechaIngreso, producto, cantidad, precio_costo_unitario;    
    target = $(this);
    
    id_compra = target.data('id'); 
    numeroOrden = target.find("td").eq(1).html();
    id_proveedor = target.data('id_p'); 
    fechaOrden = target.find("td").eq(3).html();
    fechaIngreso = target.find("td").eq(4).html();
    producto = target.data('id_producto');
    cantidad = target.find("td").eq(6).html();
    precio_costo_unitario = target.find("td").eq(7).html();

    $("#txt_id_compra").val(id_compra);
    $("#txt_noc").val(numeroOrden);
    $("#txt_id_proveedor").val(id_proveedor); 
    $("#txt_fecha_orden").val(fechaOrden);
    $("#txt_fecha_ingreso").val(fechaIngreso);
    $("#selectProductos").val(producto); 
    $("#txt_cantidad").val(cantidad);
    $("#txt_precio_unitario").val(precio_costo_unitario);

    $("#modal_nueva_compra").modal('show');
    
});


        </script>
        <script>
        function buscar() {
            const searchTerm = document.getElementById('searchField').value.toLowerCase();
            let found = false;

            // Filtrar filas en la tabla
            $('#tbl_compras tr').filter(function() {
                const isMatch = $(this).text().toLowerCase().indexOf(searchTerm) > -1;
                $(this).toggle(isMatch);
                if (isMatch) found = true; // Actualiza found si hay coincidencias
            });

            // Mostrar alerta si no se encontraron resultados
            if (!found && searchTerm.length > 0) {
                
            }
        }
    </script>

    </body>
</html>
