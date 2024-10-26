<%-- 
    Document   : Principal
    Created on : 13/10/2024, 7:21:38 a. m.
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Página Principal</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    </head>
    <body style="background-color: #d8eefe;"> <!-- Color de fondo suave -->
        <!-- Menú principal -->
        <nav class="navbar navbar-expand-lg" style="background-color: #094067;"> <!-- Color principal de la navbar -->
            <div class="container-fluid">
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="Controlador?menu=Producto" target="frame" style="color: white;">Almacen</a>
                        </li>
                        <li class="nav-item">
                            <div class="btn-group">
                                 <a class="nav-link" href="Controlador?menu=Producto" target="frame">Almacen</a>
                                <button type="button" class="btn btn-info dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false">
                                    <span class="visually-hidden">Toggle Dropdown</span>
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="Controlador?menu=Inventario" target="frame">Inventario</a></li>   
                                    <li><hr class="dropdown-divider"></li>
                                </ul>
                            </div>                        
                      </li>
                        <li class="nav-item">
                            <a class="nav-link" href="Controlador?menu=Empleado" target="frame" style="color: white;">Gestión de Empleados</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="Controlador?menu=Cliente" target="frame" style="color: white;">Clientes</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="Controlador?menu=Nueva_venta" target="frame" style="color: white;">Ventas</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="Controlador?menu=Nueva_compra" target="frame" style="color: white;">Compras</a>
                        </li>
                    </ul>
                </div>
                <!-- Botón Usuario -->
                <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false" style="background-color: #094067; border-color: #094067;">
                        ${empleado.nombres}
                    </button>
                    <ul class="dropdown-menu" style="background-color: #5f6c7b;">
                        <li><a class="dropdown-item" href="#"><i class="bi bi-file-person" style="font-size: 40px;"></i></a></li>
                        <li><a class="dropdown-item" href="#" style="color: black;">${empleado.nombres}</a></li> <!-- Color de texto -->
                        <li>
                            <a class="dropdown-item" href="index.jsp" style="color: black;">Salir</a> <!-- Redirigir al index.jsp al salir -->
                        </li>
                    </ul>
                </div>

            </div>
        </nav>

        <!-- Contenedor del iframe -->
        <div class="container mt-4" style="height: 650px;">
            <iframe name="frame" style="height: 100%; width: 100%; border: none"></iframe>       
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
