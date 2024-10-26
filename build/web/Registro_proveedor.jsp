<%-- 
    Document   : Registro_proveedor
    Created on : 23/10/2024, 7:04:07 p. m.
    Author     : user
--%>

<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page import="Modelo.Proveedores"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <h1>Proveedores</h1>
        <a href="Registro_compras.jsp">Compras</a>
        <div class="d-flex justify-content-around">
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modal_proveedor">
          Proveedor Nuevo
        </button>

        <!-- Modal -->
        <div class="modal fade" id="modal_proveedor" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                <form action="sr_cCompras?menu=Proveedores" method="post" class="form-group">
                <label for="lbl_id" ><b>ID</b></label>
                <input type="text" name="txt_id" id="txt_id" class="form-control" value="0" readonly> 
                
                <label for="lbl_proveedor" ><b>Proveedor: </b></label>
                <input type="text" name="txt_proveedor" id="txt_proveedor" class="form-control" placeholder="Primer Nombre, Segundo Nombre" required>
                
                <label for="lbl_nit" ><b>Nit:</b></label>
                <input type="text" name="txt_nit" id="txt_nit" class="form-control" placeholder="Primer Apellido, Segundo Apellido" required>
                
                <label for="lbl_direccion" ><b>Direccion:</b></label>
                <input type="text"  name="txt_direccion" id="txt_direccion" class="form-control" placeholder="#Numero de casa, calle, ciudad" required>
                
                <label for="lbl_telefono" ><b>Telefono:</b></label>
                <input type="number" name="txt_telefono" id="txt_telefono" class="form-control" placeholder="5555555" required>

                <br>
                <div class="btn-group" role="group" aria-label="Basic outlined example">
                    <button name="action" id="btn_agregar" value="agregar" class="btn btn-outline-success"><i class="bi bi-database-fill-add"></i> Agregar</button>
                    <button name="action" id="btn_modificar"  value="actualizar" class="btn btn-outline-warning"><i class="bi bi-database-fill-gear"></i> Modificar</button>
                    <button name="action" id="btn_eliminar"  value="eliminar"  class="btn btn-outline-danger" onclick="javascript:if(!confirm('¿Desea Eliminar?'))return false" ><i class="bi bi-database-fill-dash"></i> Eliminar</button>
                </div>
                
            </form>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary">Save changes</button>
              </div>
            </div>
          </div>
        </div>
        
        <div class="table-responsive" style="max-height: 300px; overflow-y: auto;">
    <table class="table table-striped table-hover">
        <thead style="position: sticky; top: 0; background-color: white; z-index: 1;">
            <tr>
                <th>ID</th>
                <th>Proveedor</th>
                <th>Nit</th>
                <th>Direccion</th>
                <th>Telefono</th>
            </tr>
        </thead>
        <tbody id="tbl_proveedor">
            <%
                Proveedores proveedores = new Proveedores();
                DefaultTableModel tabla = new DefaultTableModel();
                tabla = proveedores.leer();
                for (int t = 0; t < tabla.getRowCount(); t++) {
                    out.println("<tr data-id='" + tabla.getValueAt(t, 0) + "'>");
                    out.println("<td>" + tabla.getValueAt(t, 0) + "</td>");
                    out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                    out.println("<td>" + tabla.getValueAt(t, 2) + "</td>");
                    out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
                    out.println("<td>" + tabla.getValueAt(t, 4) + "</td>");
                    out.println("</tr>");
                }
            %>
        </tbody>
    </table>
        
        
</div>

       
      </div>
        
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

        <script>
            function limpiar(){
                $("#txt_id").val(0);
                $("#txt_proveedor").val('');
                $("#txt_nit").val('');
                $("#txt_direccion").val('');
                $("#txt_telefono").val('');
                
            }
            $('#tbl_proveedor').on('click', 'tr td', function (event) {
                var target, id, proveedor, nit, direccion, telefono;
                target = $(event.target);
                id = target.parent().data('id');
                proveedor = target.parent("tr").find("td").eq(1).html();
                nit = target.parent("tr").find("td").eq(2).html();
                direccion = target.parent("tr").find("td").eq(3).html();
                telefono = target.parent("tr").find("td").eq(4).html();

                $("#txt_id").val(id);
                $("#txt_proveedor").val(proveedor);
                $("#txt_nit").val(nit);
                $("#txt_direccion").val(direccion);
                $("#txt_telefono").val(telefono);
                $("#modal_proveedor").modal('show');
            });
        </script>
    </body>
</html>
