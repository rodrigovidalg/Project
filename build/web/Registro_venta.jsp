<%-- 
    Document   : Registro_venta
    Created on : 13/10/2024, 10:26:04 p. m.
    Author     : Christian
--%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page import="Modelo.Empleado"%>
<%@page import="Modelo.Ventas"%>
<%@page import="Modelo.Producto"%>
<%@page import="java.util.HashMap"%>
<%@page import="Modelo.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>Ventas</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    </head>
    <body>

<div class="modal fade" id="modal_nueva_venta" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Nueva Venta</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="sr_cVenta?menu=Nueva_Venta" method="post">
                    <!-- ID de venta -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="txt_id_compra"><b>ID de venta:</b></label>
                            <input type="text" name="txt_id_venta" id="txt_id_venta" class="form-control" value="" readonly>
                        </div>
                        <div class="col-md-6">
                            <label for="txt_noc"><b>Número de Factura</b></label>
                            <input type="text" name="txt_no_factura" id="txt_no_factura" class="form-control" value="">
                        </div>
                        <div class="col-md-6">
                            <label for="txt_noc"><b>Número de Serie</b></label>
                            <input type="text" name="txt_no_serie" id="txt_no_serie" class="form-control" value="">
                        </div>
                        <div class="col-md-6">
                            <label for="txt_id_empleado"><b>Empleado:</b></label>                             
                            <select name="txt_id_empleado" id="txt_id_empleado" class="form-control">
                                <%
                                    
                                    HashMap<String,String> dropP = empleado.drop_empleado();
                                    for (String i: dropP.keySet()){
                                        out.println("<option value='" + i +"'>" + dropP.get(i) +"</option>");
                                }
                                %>   
                            </select>
                        </div>
                        <!-- Proveedor -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="txt_id_Cliente"><b>Cliente:</b></label> 
                            <select name="txt_id_cliente" id="txt_id_cliente" class="form-control" required>
                                <%
                                    Cliente cliente = new Cliente();
                                    HashMap<String,String[]> drop = cliente.drop_Cliente();
                                    for (String i: drop.keySet()){
                                        String[] datos= drop.get(i);
                                        out.println("<option value = '" + i + "' "+ "data-nombre-cliente='" + datos[0] + "' " + "data-apellidos-cliente='" + datos[1] + "'> " + datos[0] + "</option>"); 
                                    }
                                %>   
                            </select>
                        </div>
                            <div class="col-md-6">
                                <label for="txt_fecha_orden"><b>Fecha de Ingreso:</b></label>
                                <input type="date" name="txt_fecha_ingreso" id="txt_fecha_ingreso" class="form-control" required>
                            </div>
                          
                               <div class="col-md-6">
                                    <label for="txt_fecha_factura"><b>Fecha factura:</b></label>
                                    <input type="date" name="txt_fecha_factura" id="txt_fecha_factura" class="form-control" required>
                                </div>
                        </div>
                                
                    </div>
                    <!-- Detalles de Productos -->
                    <h5>Detalle de la venta</h5>
                    <div id="detalles_productos">
                        <!-- Aquí se agregarán dinámicamente los productos -->
                        <div class='row mb-3 producto-row'>
                            <div class='col-md-4'>
                                <label for='id_producto'><b>Producto:</b></label>
                                <select name="txt_id_producto" id="txt_id_producto" class="form-control" required>
                                    <%
                                        Producto producto = new Producto();
                                        HashMap<String,String[]> productosMap = producto.drop_sangre();
                                            System.out.println("Cantidad de productos encontrados: " + productosMap.size());

                                        //string id o i es lo mismo solo que es mas representativo el id porque con eso se trabaja
                                        for (String id: productosMap.keySet()){
                                            String[] datos= productosMap.get(id);
                                            out.println("<option value = '" + id + "' "+ "data-nombre='" + datos[0] + "' " + "data-marca='" + datos[1] + "' " + "data-precio='" + datos[2] + "' "+ "data-existencia='" + datos[3] + "'> " + datos[0] + "</option>"); 
                                        }
                                        %>     
                                </select>
                            </div>
                            <div class='col-md-4'>
                                <label for='cantidad'><b>Cantidad:</b></label>
                                <input type='number' name='txt_cantidad' min='1' class='form-control' id="txt_cantidad"  required onchange="calcularPrecioTotal()"/>
                            </div>
                            <div class='col-md-4'>
                                <label for='precio_unitario'><b>Precio Unitario:</b></label>
                                <input type='number' step='.01' name='txt_precio_unitario' class='form-control' id="txt_precio_unitario" required onchange="calcularPrecioTotal()"/>
                            </div>
                        </div>
                        <div class='col-md-4'>
                               <label for='precio_unitario'><b>Precio Total:</b></label>
                               <input type='number' step='.01' name='txt_precio_total' id ='txt_precio_total'  class='form-control' id="txt_precio_total" readonly>
                        </div>
                    </div>

                    <!-- Acciones -->
                    <div class='row mt-3'>
                        <div class='col-md-4'>
                            <button name='action' value='agregar' class='btn btn-outline-success w-100'>Generar Venta</button>
                        </div>
                        <div class='col-md-4'>
                            <button name='action' value='actualizar' class='btn btn-outline-warning w-100'>Modificar</button>
                        </div>
                        <div class='col-md-4'>
                            <button name='action' value='eliminar'
                                    onclick='javascript:if(!confirm("¿Desea Eliminar?"))return false'
                                    class='btn btn-outline-danger w-100'>Eliminar Venta</button>
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
                    
                    
                    
                   
    <div class="table-responsive" style="max-height: 300px; overflow-y: auto;">
        <table class="table table-striped table-hover">
            <thead style="position: sticky; top: 0; background-color: white; z-index: 1;">
                <tr>
                    <th>ID Venta</th>
                    <th>Número de factura</th>
                    <th>Número de serie</th>
                    <th>Fecha Factura</th>
                    <th>Cliente</th>
                    <th>Empleado</th>
                    <th>Fecha_ingreso</th>
                    <th>Imagen producto</th>
                    <th>Producto</th>
                    <th>Cantidad</th>
                    <th>Precio Unitario</th>
                </tr>
            </thead>
            <tbody id="tbl_ventas">
                <%
                    Ventas ventas = new Ventas();
                    DefaultTableModel tablaVentas = ventas.leer(); // Usando el nuevo método

                    for (int t = 0; t < tablaVentas.getRowCount(); t++) {
                        out.println("<tr data-id='" + tablaVentas.getValueAt(t, 0) + "' data-id_c='" + tablaVentas.getValueAt(t, 4) + "' data-id_e='" + tablaVentas.getValueAt(t, 5) + "'>");
                        out.println("<td>" + tablaVentas.getValueAt(t, 0) + "</td>"); // ID Venta
                        out.println("<td>" + tablaVentas.getValueAt(t, 1) + "</td>"); // Número de Factura
                        out.println("<td>" + tablaVentas.getValueAt(t, 2) + "</td>"); // Número de Serie
                        out.println("<td>" + tablaVentas.getValueAt(t, 3) + "</td>"); // Fecha de Factura
                        out.println("<td>" + tablaVentas.getValueAt(t, 4) + "</td>"); // Cliente
                        out.println("<td>" + tablaVentas.getValueAt(t, 5) + "</td>"); // Empleado
                        out.println("<td>" + tablaVentas.getValueAt(t, 6) + "</td>"); // Fecha de Ingreso
                        out.println("<td>" + tablaVentas.getValueAt(t, 7) + "</td>"); // ID Producto
                        out.println("<td>" + tablaVentas.getValueAt(t, 8) + "</td>"); // Producto
                        out.println("<td>" + tablaVentas.getValueAt(t, 9) + "</td>"); // Cantidad
                        out.println("<td>" + tablaVentas.getValueAt(t, 10) + "</td>"); // Precio Unitario
                        out.println("</tr>");
                    }
                %>
            </tbody>
        </div>       
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
                      
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" onclick="limpiar()"data-bs-target="#modal_nueva_venta">
                    Venta nueva
                    </button> 
        <script>
         function limpiar(){
            $("#txt_id_venta").val(0);
            $("#txt_no_factura").val('');
            $("#txt_no_serie").val('');
            $("#txt_fecha_factura").val('');
            $("#txt_fecha_ingreso").val('');
            $("#txt_cantidad").val('');
            $("#txt_precio_unitario").val('');
            $("#txt_id_producto").val(1); // Seleccionar producto  
            $("#txt_id_empleado").val(1); // Seleccionar empleado 
            $("#txt_id_cliente").val(1); // Seleccionar cliente

            
        }    
             
               $(document).ready(function() {
    // Manejar el evento click en las filas de la tabla
    $('#tbl_ventas tr').click(function() {
        var id_venta = $(this).data('id');
        var id_c = $(this).data('id_c');
        var id_e = $(this).data('id_e');

        // Obtener valores de las celdas correspondientes
        var no_factura = $(this).find('td:nth-child(2)').text();
        var no_serie = $(this).find('td:nth-child(3)').text();
        var fecha_factura = $(this).find('td:nth-child(4)').text();
        var fecha_ingreso = $(this).find('td:nth-child(7)').text();
        var producto = $(this).find('td:nth-child(9)').text();
        var cantidad = $(this).find('td:nth-child(10)').text();
        var precio_unitario = $(this).find('td:nth-child(11)').text();

        // Asignar los valores a los inputs
        $("#txt_id_venta").val(id_venta);
        $("#txt_no_factura").val(no_factura);
        $("#txt_no_serie").val(no_serie);
        $("#txt_fecha_factura").val(fecha_factura);
        $("#txt_fecha_ingreso").val(fecha_ingreso);
        $("#txt_cantidad").val(cantidad);
        $("#txt_precio_unitario").val(precio_unitario);
        
        // Mostrar el modal
        $("#modal_nueva_venta").modal('show');
        });
    });
    
    function calcularPrecioTotal() {
        // Obtener los valores de cantidad y precio unitario
        const cantidad = parseFloat($('#txt_cantidad').val()) || 0; // Valor por defecto es 0 si no es un número
        const precioUnitario = parseFloat($('#txt_precio_unitario').val()) || 0; // Valor por defecto es 0 si no es un número

        // Calcular el precio total
        const precioTotal = cantidad * precioUnitario;

        // Asignar el precio total al campo correspondiente
        $('#txt_precio_total').val(precioTotal.toFixed(2)); // Formatear a dos decimales
    }

            </script>
    </body>
</html>
