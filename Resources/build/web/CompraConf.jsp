
<%@page import="Modelo.Usuarios"%>
<%@page import="Modelo.CarritoCompras"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%  HttpSession Session = request.getSession();
    Usuarios objUser = null;
    boolean flagsession = false;
    if (Session.getAttribute("CarritoUser") == null) {
        request.getRequestDispatcher("tienda.jsp").forward(request, response);
    } else {
        if (Session.getAttribute("DatosUser") != null) {
            objUser = (Usuarios) Session.getAttribute("DatosUser");
            flagsession = true;

        } else {
            request.getRequestDispatcher("tienda.jsp").forward(request, response);
        }
        Usuarios objUsu = (Usuarios) Session.getAttribute("DatosUser");
        List<CarritoCompras> objlistcarrito = (List<CarritoCompras>) Session.getAttribute("CarritoUser");
        if (objlistcarrito.size() == 0) {
            request.getRequestDispatcher("tienda.jsp").forward(request, response);
        }

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SendPacker</title>
        <link rel="shortcut icon" href="resourse/img/favicon.ico">
        <link rel="stylesheet" type="text/css" href="resourse/bootstrap/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="resourse/font-awesome/css/fontawesome-all.css">
        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="resourse/css/maps.css">

    </head>
    <style>
        .styletabla{
            padding-top: 100px;
        }
        .navbar {
            font-family: Montserrat, sans-serif;
            margin-bottom: 0;
            background-color: #2ecc71;
            border: 0;
            font-size: 13px !important;
            opacity: 0.9;
            /*barra*/
        }


        .navbar li {
            padding-top: 20px;
            padding-bottom: 20px;
            padding-left: 2em;
            padding-right: 2em;
        }

        .navbar li:hover {
            background: white;
        }

        .navbar li a, .navbar .navbar-brand {
            color: black;
            text-decoration: none;    
            /*color de letras de barra*/
        }

        .navbar-nav li.active a {
            color: #fff !important;
            background-color: #29292c !important;
        }

        .navbar-default .navbar-toggle {
            border-color: transparent;
        }

        .open .dropdown-toggle {
            color: #fff;
            background-color: #555 !important;
        }

        .dropdown-menu{
            font-size: 13px !important;
        }

        .dropdown-menu a {
            color: #000 !important;
        }

        .dropdown-menu a:hover {
            background-color: red !important;
        }

        .alert{
            margin-bottom: 0px;
            margin-right: 1em;
            left: auto;
        }

        @media (max-width: 992px){
            .navbar{
                opacity: 1;
            }
            .navbar li {
                padding-top: 10px;
                padding-bottom: 10px;
                padding-left: 2em;
                padding-right: 2em;

            }
            .dropdown:hover .dropdown-menu{
                border: none;
                background: white !important;
                border-radius: 0px !important;
            }
            .dropdown-menu{
                background: #2ecc71;
                border:none;
            }
            .alert{
                margin-right: 0em;
            }

        }
    </style>
    <body  bgcolor="#ECF0F1" class="encab">
        <div class="container-fluid">
            <header>
                <nav class="navbar navbar-expand-lg fixed-top navbar-dark">
                    <div class="container-fluid">
                        <a class="navbar-brand" href="#myPage"><img src="resourse/img/Logo.png" style="width: 55px;"></a><!-- Agragas aqui la imagen del logo-->
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#myNavbar"
                                aria-controls="myNavbar" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="myNavbar">
                            <ul class="nav navbar-nav">
                                <li><a href="index.jsp">INICIO</a></li>
                                <li><a href="index.jsp#nosotros">NOSOTROS</a></li>
                                <li><a href="index.jsp#contact">CONTACTANOS</a></li>
                                <li><a href="tienda.jsp">TIENDA</a></li>
                                    <%if (flagsession) {%>
                                <li class="dropdown">
                                    <a class="dropdown-toggle" data-toggle="dropdown" href="#"><i class="fas fa-user-circle"></i> <%=objUser.getNombres().toUpperCase()%></a>
                                    <div class="dropdown-menu">
                                        <a class="dropdown-item" href="AccountUserEdit.jsp">MI CUENTA</a>
                                        <a class="dropdown-item" href="AccountUserSell.jsp">MIS COMPRAS</a>
                                        <a id="btn_cerrar_U" class="dropdown-item" href="#">CERRAR SESION</a>
                                    </div>
                                </li>
                                <form action="ServletCliente" method="POST" id="CerrarU">
                                    <input type="hidden" name="op" id="op" value="3"/> 
                                </form>
                                <%} else {%>
                                <li class="dropdown">
                                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">INICIAR SESION</a>
                                    <div class="dropdown-menu">
                                        <a class="dropdown-item" href="login_prov.jsp">PROVEEDOR</a>
                                        <a class="dropdown-item" href="login_user.jsp">USUARIO</a>
                                    </div>
                                </li><%}%>
                            </ul>
                        </div>
                    </div>
                </nav>
            </header>
            <div class="styletabla">										
                <div class="row">
                    <div class="col-sm-12">
                        <table class="table table-responsive-sm table-bordered">
                            <thead class="thead-light">
                            <th>Codigo</th><th>Articulo</th><th>Cantidad</th><th>Precio</th><th>Total</th><th style="width: 130px;">Acciones</th>
                            </thead>
                            <% float total = 0;
                                for (CarritoCompras listarCar : objlistcarrito) {
                                    total = total + listarCar.getTotal();
                            %>
                            <tr>
                                <th><%=listarCar.getCod()%></th>
                                <td><%=listarCar.getNom()%></td>
                                <td><%=listarCar.getCant()%></td>
                                <td><%=listarCar.getPrec()%></td>
                                <td><%=listarCar.getTotal()%></td>
                                <td><button type="button" id="btn_edit_<%=listarCar.getCod()%>" name="btn_edit" class="btn btn-primary my-1" data-toggle="modal" data-target="#modal_edit_arti"><i class="fas fa-pencil-alt"></i></button>
                                    <button type="button" id="btn_del_<%=listarCar.getCod()%>" name="btn_del" class="btn btn-danger my-1" data-toggle="modal" data-target="#modal_del_arti"><i class="fas fa-minus-circle"></i></button>
                                </td>
                            </tr>
                            <% }%>
                        </table>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-sm-4">
                        <div class="row">
                            <div class="col-sm-12 py-1">
                                <div class="card">
                                    <div class="card-header">
                                        Detalles de Compra
                                    </div>
                                    <div class="card-body">
                                        <strong>DNI :</strong><%=objUsu.getDNI()%><br>
                                        <strong>Nombre :</strong><%=objUsu.getNombres()%><br>
                                        <strong>Apellidos :</strong><%=objUsu.getApelPaterno() + " " + objUsu.getApelMaterno()%><br>
                                        <strong>Email :</strong><%=objUsu.getEmail()%><br>
                                        <strong>Celular :</strong><%=objUsu.getCel()%><br>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 py-1">
                                <div class="card">
                                    <div class="card-header">
                                        Forma de Pago
                                    </div>
                                    <div class="card-body">
                                        <form id="ultdatos" method="POST" action="ServletCliente">
                                            <input type="hidden" name="op" value="5"/>
                                            <input type="hidden" name="long" id="long"/><input type="hidden"id="lat" name="lat"/>
                                            <div class="row">
                                                <div class="col-sm-12 py-1">
                                                    <label>Propietario de Tarjeta</label>
                                                    <input class="form-control" required>
                                                </div>
                                            </div>                                                      
                                            <div class="row">
                                                <div class="col-sm-12 py-1">
                                                    <label>Ingrese Numero de Tarjeta</label>
                                                    <input class="form-control" required>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-6 py-1">
                                                    <label>CCV</label>
                                                    <input class="form-control" required>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-12 py-1">
                                                    <label>Fecha Expiracion :   </label>
                                                </div>
                                            </div>
                                            <div class="form-row">
                                                <div class="col-sm-6 py-1">
                                                    <input class="form-control" placeholder="Mes" required>
                                                </div>
                                                <div class="col-sm-6 py-1">
                                                    <input class="form-control" placeholder="Año" required>
                                                </div>
                                            </div> 
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-8">
                        <div class="row">
                            <div class="col-sm-12 py-1">
                                <div class="card">
                                    <div class="card-header">
                                        Seleccione Ubicacion de Despacho
                                    </div>
                                    <div class="card-body" style="padding: 0">
                                        <div class="limitermap">
                                            <div id="map" class="map">  
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 py-1">
                                <div class="card">
                                    <div class="card-header">
                                        Total a Pagar
                                    </div>
                                    <div class="card-body">
                                        <div class="form-row">
                                            <div class="col-sm-2 py-sm-1">
                                                <label>SubTotal:</label>
                                                <input class="form-control" value="<%=(total / 1.18)%>"  readonly>
                                            </div>
                                            <div class="col-sm-2 py-sm-1">
                                                <label>IGV</label>
                                                <input class="form-control" value="<%=(total * 0.18)%>" readonly>
                                            </div>
                                            <div class="col-sm-2 py-sm-1">
                                                <label>Total</label>
                                                <input class="form-control" form="ultdatos" name="totalcompra" value="<%=total%>" readonly>
                                            </div>
                                            <div class="col-sm-2 py-1">
                                                <label>Acciones</label>
                                                <button type="submit" class="btn btn-success" id="btn_comprar" form="ultdatos" disabled>Comprar</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="modal_del_arti" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog " role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Eliminar</h5>
                            <button type="button" class="close" data-dismiss="modal">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form action="ServletCliente" method="POST" id="del_arti">
                                <input type="hidden" id="codarti" name="codarti"/>
                                ¿Desea Eliminar el producto del Carrito?
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                            <button type="submit" form="del_arti" class="btn btn-danger">Eliminar</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="modal_edit_arti" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog " role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Editar Cantidad</h5>
                            <button type="button" class="close" data-dismiss="modal">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form action="ServletCliente" method="POST" id="mod_cant">
                                <input type="hidden" id="codart_cant" name="codart_cant"/>
                                <label>Cantidad Requerida: </label>
                                <input type="number" class="form-control" id="cantarti" name="cantarti"/>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                            <button type="submit" form="mod_cant" class="btn btn-success">Editar</button>
                        </div>
                    </div>
                </div>
            </div>
            <footer align="right" class="pb-3">
                &copy;2018 SendPacker </a>
            </footer>
        </div>
        <%if (request.getAttribute("error") != null) {%>
        <div class="alert alert-danger alert-dismissible fade show fixed-bottom col-lg-3" id="error_alert" role="alert">
            <strong id="error_msg"><%=request.getAttribute("error")%></strong>
            <button type="button" class="close" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <%}else{%>
         <div class="alert alert-danger alert-dismissible fade fixed-bottom col-lg-3" id="error_alert" role="alert">
            <strong id="error_msg"></strong>
            <button type="button" class="close" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <%}%>
         <%if (request.getAttribute("msg") != null) {%>
        <div class="alert alert-success alert-dismissible fade show fixed-bottom col-lg-3" id="sucess_alert" role="alert">
            <strong id="sucess_msg"><%=request.getAttribute("msg")%></strong>
            <button type="button" class="close" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <%}%>
    </body>
    <script type="text/javascript" src="resourse/jquery/jquery.js"></script>
    <script type="text/javascript" src="resourse/bootstrap/js/bootstrap.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDcCBmYTSMPzTaZS7ISySW-iXUSKQyvKQY"></script>
    <script type="text/javascript" src="resourse/js/tienda.js"></script>
</html><%}%>