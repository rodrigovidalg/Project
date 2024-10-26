<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestión de Clientes</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Sección Izquierda: Datos del cliente -->
                <div class="col-md-3 p-4 bg-light">
                    <div class="card">
                        <img src="https://i.pinimg.com/originals/c6/96/f8/c696f868fb6ccfcc908b72f07f58089a.jpg" class="card-img-top" alt="Imagen del cliente">
                        <div class="card-body">
                            <h5 class="card-title">Gustavo Morales</h5>
                            <p class="card-text"><strong>ID:</strong> 9</p>
                            <p class="card-text"><strong>NIT:</strong> 12345678</p>
                            <p class="card-text"><strong>Teléfono:</strong> 257-4420</p>
                            <p class="card-text"><strong>Correo:</strong> gustavo.mls@gmail.com</p>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#nuevoClienteModal">
                                Cliente
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Sección Derecha: Tabla y búsquedas -->
                <div class="col-md-9 p-4">
                    <h3>Información de Compras</h3>
                    
                    <!-- Buscador de Clientes -->
                    <form method="post" action="sr_controlador?menu=Cliente&accion=buscar">
                        <div class="input-group mb-3">
                            <input type="text" name="txt_nit_buscar" class="form-control" placeholder="Buscar cliente por NIT" required>
                            <button class="btn btn-outline-secondary" type="submit"><i class="bi bi-search"></i></button>
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
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombres</th>
                                <th>Apellidos</th>
                                <th>NIT</th>
                                <th>Teléfono</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Gustavo</td>
                                <td>Morales</td>
                                <td>12345678</td>
                                <td>257-4420</td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Maria</td>
                                <td>Lopez</td>
                                <td>87654321</td>
                                <td>6712-4455</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Modal para agregar o modificar cliente -->
        <div class="modal fade" id="nuevoClienteModal" tabindex="-1" aria-labelledby="nuevoClienteModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="nuevoClienteModalLabel">Agregar o Modificar Cliente</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="sr_controlador?menu=Cliente&accion=guardar">
                            <div class="mb-3">
                                <label for="idCliente" class="form-label">ID</label>
                                <input type="text" name="txt_id" id="txt_id" class="form-control" value="0" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="nombresCliente" class="form-label">Nombres</label>
                                <input type="text" name="txt_nombres" class="form-control" id="nombresCliente" required>
                            </div>
                            <div class="mb-3">
                                <label for="apellidosCliente" class="form-label">Apellidos</label>
                                <input type="text" name="txt_apellidos" class="form-control" id="apellidosCliente" required>
                            </div>
                            <div class="mb-3">
                                <label for="nitCliente" class="form-label">NIT</label>
                                <input type="text" name="txt_nit" class="form-control" id="nitCliente" required>
                            </div>
                            <div class="mb-3">
                                <label for="generoCliente" class="form-label">Género</label>
                                <select name="txt_genero" class="form-control" id="generoCliente">
                                    <option value="true">Masculino</option>
                                    <option value="false">Femenino</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="telefonoCliente" class="form-label">Teléfono</label>
                                <input type="text" name="txt_telefono" class="form-control" id="telefonoCliente" required>
                            </div>
                            <div class="mb-3">
                                <label for="correoCliente" class="form-label">Correo Electrónico</label>
                                <input type="email" name="txt_correo" class="form-control" id="correoCliente" required>
                            </div>
                            <div class="mb-3">
                                <label for="fechaIngresoCliente" class="form-label">Fecha de Ingreso</label>
                                <input type="date" name="txt_fecha_ingreso" class="form-control" id="fechaIngresoCliente" required>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">Guardar Cliente</button>
                                <button  name="btn_actualizar" id="btn_actualizar" value="actualizar" class="btn btn-primary">Actualizar</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
