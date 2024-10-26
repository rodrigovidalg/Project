<%@ page import="Modelo.Producto" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.logging.Level" %>
<%@ page import="java.util.logging.Logger" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gestión de Productos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="card shadow">
            <div class="card-header bg-primary text-white text-center">
                <h2>Ingresar Producto</h2>
            </div>
            <div class="card-body">
                <form action="sr_controlador" method="post">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="producto" class="form-label">Producto</label>
                            <input type="text" class="form-control" id="producto" name="producto" required>
                        </div>
                        <div class="col-md-6">
                            <label for="id_marca" class="form-label">Marca</label>
                            <input type="number" class="form-control" id="id_marca" name="id_marca" required>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-12">
                            <label for="descripcion" class="form-label">Descripción</label>
                            <textarea class="form-control" id="descripcion" name="descripcion" rows="3"></textarea>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label for="precio_costo" class="form-label">Precio Costo</label>
                            <input type="number" step="0.01" class="form-control" id="precio_costo" name="precio_costo" required>
                        </div>
                        <div class="col-md-4">
                            <label for="precio_venta" class="form-label">Precio Venta</label>
                            <input type="number" step="0.01" class="form-control" id="precio_venta" name="precio_venta" required>
                        </div>
                        <div class="col-md-4">
                            <label for="existencia" class="form-label">Existencia</label>
                            <input type="number" class="form-control" id="existencia" name="existencia" required>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label for="fecha_ingreso" class="form-label">Fecha de Ingreso</label>
                            <input type="datetime-local" class="form-control" id="fecha_ingreso" name="fecha_ingreso">
                        </div>
                    </div>
                    <div class="text-center">
                        <button type="submit" name="accion" value="Guardar" class="btn btn-success me-2">
                            <i class="bi bi-check-lg"></i> Guardar
                        </button>
                        <button type="submit" name="accion" value="Eliminar" class="btn btn-danger me-2">
                            <i class="bi bi-trash"></i> Eliminar
                        </button>
                        <button type="reset" class="btn btn-secondary">
                            <i class="bi bi-x-lg"></i> Cancelar
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
