<%-- 
    Document   : index
    Created on : 13/10/2024, 7:21:14 a. m.
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    </head>
    <body style="background-color: #d8eefe; padding: 20px;background-image: url('img/fondo.png');">
             <div class="container mt-4 col-lg-4">
            <div class="container vh-100 d-flex justify-content-center align-items-center">
            <div class="card col-sm-10" style="background-color: #d8eefe; padding: 20px;">
                <div class="card-body" style="background-color: #d8eefe; padding: 20px;">
                    <form class="form-sing" action="sr_cIndex" method="POST">
                        <div class="form-group text-center mb-3">
                            <h2>BIENVENIDO AL SISTEMA</h2>
                            <img src="img/logo.png" alt="Logo" class="rounded-circle" width="80">
                        </div>

                        <div class="form-group mb-3">
                            <label for="username" class="blockquote"><i class="bi bi-person"></i> Usuario:</label>
                            <input type="text" name="txt_user" id="username" class="form-control" placeholder="Ingrese su usuario" required>
                        </div>

                        <div class="form-group mb-3">
                            <label for="password" class="blockquote"><i class="bi bi-lock"></i> Contraseña:</label>
                            <input type="password" name="txt_pass" id="password" class="form-control" placeholder="Ingrese su contraseña" required>
                        </div>

                        <div class="form-group text-center mb-4">
                            <input type="submit" name="accion" value="Ingresar" class="btn btn-danger">
                        </div>

                        <div class="alert alert-danger" role="alert" style="display:none;" id="error-message">
                            Usuario o contraseña incorrectos.
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
