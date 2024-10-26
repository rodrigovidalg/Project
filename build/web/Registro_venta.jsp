<%-- 
    Document   : Registro_venta
    Created on : 13/10/2024, 10:26:04 p. m.
    Author     : Christian
--%>
<%@page import="Modelo.Producto"%>
<%@page import="java.util.HashMap"%>
<%@page import="Modelo.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ventas</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    </head>
    <body>
        <div class="d-flex">
            <div class="col-sm-4">
                <div class="card">
                    <form action="Controlador" method="POST">
                        <div class="card-body">
                            <div class="form-group">
                                <label>Datos del Cliente</label>
                            </div>
                            <div class="form-group d-flex">
                                
                                <select name="drop_cliente" id="drop_cliente" class="form-control" onchange="cargarCliente(this.value)">
                                    <%
                                    Cliente cliente = new Cliente();
                                    HashMap<String,String[]> drop = cliente.drop_Cliente();
                                    for (String i: drop.keySet()){
                                        String[] datos= drop.get(i);
                                        out.println("<option value = '" + i + "' "+ "data-nombre-cliente='" + datos[0] + "' " + "data-apellidos-cliente='" + datos[1] + "'> " + datos[0] + "</option>"); 
                                    }
                                    %>   
                                </select>
                                
                                <div class="col-sm-6">
                                    <input type="text" name="nombres_cliente" id="nombreCliente" class="form-control" placeholder="Datos Cliente" readonly>
                                </div>
                                <div class="col-sm-6">
                                    <input type="text" name="nombres_cliente" id="apellidosCliente" class="form-control" placeholder="Datos Cliente" readonly>
                                </div>
                            </div>
                            <div>
                                <label>Datos Producto</label>
                            </div>
                            <div class="form-group d-flex">
                                    <select name="drop_producto" id="drop_producto" class="form-control" onchange="cargarProducto(this.value)" placeholder="ID">
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
                                    
                                <div class="col-sm-6 d-flex">
                                    <input type="text" name="id_producto" id="nombreProducto"class="form-control" placeholder="Nombre Producto" readonly>
                                </div>
                                <div class="col-sm-6 d-flex">
                                    <input type="text" name="nombres_producto" id="marcaProducto"class="form-control" placeholder="Marca Producto" readonly>
                                </div>
                            </div>
                            <div class="form-group d-flex">
                                <div class="col-sm-6 d-flex">
                                    <input type="text" name="precio_producto" id="precioProducto" class="form-control mr-2" placeholder="Precio" readonly>
                                </div>
                                <div class="col-sm-3 d-flex">
                                    <input type="number" name="cantidad_producto" class="form-control" placeholder="Cantidad" min="1" value="1">
                                </div>
                                <div class="col-sm-3 d-flex">
                                    <input type="text" name="stock" id="existenciaProducto" class="form-control mr-2" placeholder="Stock" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <button type="button" class="btn btn-outline-info" onclick="agregarProducto()">Agregar Producto</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            
                <div class="col-sm-8">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex col-ms-5 ml-auto">
                                <label>No. Serie</label>
                                <input type="text" name="No_Serie" class="form-control">
                            </div>
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>No. Factura</th>
                                        <th>Cod Producto</th>
                                        <th>Producto</th>
                                        <th>Descripción</th>
                                        <th>Imagen</th>
                                        <th>cantidad</th>
                                        <th>SubTotal</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody id="tabla_productos">
                                </tbody>
                            </table>
                            <div class="d-flex justify-content-between">
                            <h6>Total a Pagar:</h6>
                            <h6>Q 0.00</h6>
                            </div>
                          
                        </div>
                        <div class="card-footer">
                            <button type="submit" name="accion" value="Generar Venta" class="btn btn-success"><i class="bi bi-receipt-cutoff"></i> Generar Venta</button>
                            <button type="submit" name="accion" value="Cancelar" class="btn btn-danger"><i class="bi bi-x"></i> Cancelar</button>
                        </div>
                    </div>
                </div>
        </div>
        <script type="text/javascript">
        // JavaScript para actualizar los campos de texto al seleccionar un producto
        function cargarProducto() {
            const select = document.getElementById("drop_producto");
            const opcionSeleccionada = select.options[select.selectedIndex];

            document.getElementById("nombreProducto").value = opcionSeleccionada.getAttribute("data-nombre") || "";
            document.getElementById("marcaProducto").value = opcionSeleccionada.getAttribute("data-marca") || "";
            document.getElementById("precioProducto").value = opcionSeleccionada.getAttribute("data-precio") || "";
            document.getElementById("existenciaProducto").value = opcionSeleccionada.getAttribute("data-existencia") || "";
        
        }
        function cargarCliente(){
            const select = document.getElementById("drop_cliente");
            const opcionSeleccionada = select.options[select.selectedIndex];

            document.getElementById("nombreCliente").value = opcionSeleccionada.getAttribute("data-nombre-cliente") || "";
            document.getElementById("apellidosCliente").value = opcionSeleccionada.getAttribute("data-apellidos-cliente") || "";
            
        }
        
        function agregarProducto() {
            const selectProducto = document.getElementById("drop_producto");
            const opcionProducto = selectProducto.options[selectProducto.selectedIndex];

            const codigoProducto = opcionProducto.value;
            const nombreProducto = opcionProducto.getAttribute("data-nombre");
            const marcaProducto = opcionProducto.getAttribute("data-marca");
            const precioProducto = parseFloat(opcionProducto.getAttribute("data-precio")) || 0;
            const cantidadProducto = parseInt(document.querySelector('input[name="cantidad_producto"]').value) || 1;
            let stock = parseInt(opcionProducto.getAttribute("data-existencia")) || 0;

            // Verificar disponibilidad de stock
            if (cantidadProducto > stock) {
                alert("No hay suficiente stock disponible.");
                return;
            }

            const subTotal = precioProducto * cantidadProducto;

            // Depuración
            console.log(`Producto: ${nombreProducto}, Marca: ${marcaProducto}, Precio: ${precioProducto}, Cantidad: ${cantidadProducto}, SubTotal: ${subTotal}`);

            const tbody = document.getElementById("tabla_productos");
            const fila = document.createElement("tr");

            // Actualizar el stock después de agregar el producto
            stock -= cantidadProducto; // Resta la cantidad vendida al stock original

            fila.innerHTML = `
                <td>001</td> <!-- Aquí podrías generar un número de factura único -->
                <td>${codigoProducto}</td>
                <td>${nombreProducto}</td>
                <td>${marcaProducto}</td>
                <td></td> <!-- Aquí podrías agregar una imagen si la tienes -->
                <td>${cantidadProducto}</td>
                <td>Q ${subTotal.toFixed(2)}</td>
                <td>
                    <button class="btn btn-success btn-sm" onclick="guardarProducto()">✓</button>
                    <button class="btn btn-danger btn-sm" onclick="eliminarProducto(this, ${subTotal}, ${cantidadProducto})">🗑️</button>
                </td>
            `;

            tbody.appendChild(fila);
            actualizarTotal(subTotal);

            // Actualiza el stock en el atributo de la opción seleccionada
            opcionProducto.setAttribute("data-existencia", stock);
            opcionProducto.textContent = `${nombreProducto} (Stock: ${stock})`; // Actualiza el texto del dropdown para mostrar el stock restante
        }

        function eliminarProducto(btn, subTotal, cantidadProducto) {
            const fila = btn.parentElement.parentElement;
            fila.remove();
            total -= subTotal;

            // Recupera el producto y actualiza el stock
            const selectProducto = document.getElementById("drop_producto");
            const opcionProducto = selectProducto.options[selectProducto.selectedIndex];
            let stock = parseInt(opcionProducto.getAttribute("data-existencia")) || 0;
            stock += cantidadProducto; // Aumenta el stock por la cantidad eliminada
            opcionProducto.setAttribute("data-existencia", stock);
            opcionProducto.textContent = `${opcionProducto.getAttribute("data-nombre")} (Stock: ${stock})`; // Actualiza el texto del dropdown

            document.querySelector("h6 + h6").textContent = `Q ${total.toFixed(2)}`;
        }

        </script>                       
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
