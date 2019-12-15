<%@page import="Modelo.Usuarios"%>
<%@page import="Modelo.CarritoCompras"%>
<%@page import="java.util.List" %>
<%@page import="Modelo.Articulos" %>
<%@page import="DAO.ListarArticulos" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% HttpSession Session = request.getSession();
    boolean flagsession = false;
    boolean flagcarrito = false;
    int cant = 0;
    Usuarios objUser = null;
    if (Session.getAttribute("DatosUser") != null) {
        objUser = (Usuarios) Session.getAttribute("DatosUser");
        flagsession = true;
    }
    if (Session.getAttribute("CarritoUser") != null) {
        List<CarritoCompras> objlistcarrito = (List<CarritoCompras>) Session.getAttribute("CarritoUser");
        cant = objlistcarrito.size();
        flagcarrito = true;
    }
    ListarArticulos objListaA = new ListarArticulos();
    List<Articulos> listaA = objListaA.ListarArticulos();
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Tienda Productos</title>
        <link rel="shortcut icon" href="resourse/img/favicon.ico">
        <link href="resourse/bootstrap/css/bootstrap.css" rel="stylesheet"/>
        <link href="resourse/css/style.market.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="resourse/font-awesome/css/fontawesome-all.css">
        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
        <script src="resourse/jquery/jquery.js"></script>
    </head>
     <style>
        .alert{
            margin-bottom: 0px;
            margin-right: 1em;
            left: auto;
        }

        @media (max-width: 992px){
            .alert{
                margin-right: 0em;
            }
        }
    </style>
    <body>
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
                                <%if (flagcarrito && cant!=0) {%>
                            <li><a href="CompraConf.jsp"><i class="fas fa-shopping-cart"></i> <span class="badge badge-light"><%=cant%></span></a></li><%}%>
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
                                <input type="hidden" name="op" value="3"/> 
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
        <div class="row img-market" style="margin: 0px;" id="fondo_tienda">
            <div class="col-sm-12 text-center " style="padding-right: 0px; padding-left: 0px;">
                <img src="resourse/img/Logo.png" class="img-fluid img-arti">
            </div>
        </div>
        <div class="container-fluid fondo-market">
            <div class="row justify-content-center">
                <div class="col-sm-10" id="arti-fond">
                    <div class="d-flex flex-wrap justify-content-around">
                        <% for (int i = 0; i < listaA.size(); i++) {%>
                        <div class="p-3 my-3 arti-block">
                            <div class="row">
                                <div class="col-sm-12">
                                    <p>Cod. Arti. <%=listaA.get(i).getCod()%>
                                    </p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12 text-center">
                                    <img src="<%=listaA.get(i).getRutaimg()%>" class="img-fluid img-arti">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12 text-center">
                                    <h6><%=listaA.get(i).getNom()%>
                                    </h6>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12 text-center">
                                    <h4>S/. <%=listaA.get(i).getPrecio()%>
                                    </h4>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">

                                    <button class="btn btn-success btn-block" name="btn_detalles" id="btn_<%=listaA.get(i).getCod()%>" data-toggle="modal" data-target="#Detalles">Ver
                                        Detalles
                                    </button>

                                </div>
                            </div>
                        </div>
                        <%}%>
                    </div>
                </div>
            </div>
        </div>
        <footer>
            <div class="row bg-dark p-2 justify-content-end" style="margin-right: 0px; margin-left: 0px;">
                <div class="col-sm-2" style="padding-right: 0px; padding-left: 0px;">
                    <p class="pr-3 text-white">© 2018 Developed UTP</p>
                </div>
            </div>
        </footer>
        <!-- Modal De Detalles -->
        <div class="modal fade" id="Detalles" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Detalles de Producto</h5>
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" id="modal-body">
                        <form id="InsCarrito" action="ServletCliente" method="POST">
                            <input type="hidden" name="op" value="4">
                            <div class="row">
                                <div class="col-sm-6" id="img_detaarti">
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <div class="col-sm-12" id="cod">                  
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12" id="title" >
                                        </div>
                                    </div>
                                    <div class="row py-3">
                                        <div class="col-sm-12" id="prec">
                                        </div>
                                    </div>    
                                    <div class="row">
                                        <div class="col-sm-4">
                                            <label>Cantidad</label>
                                            <input type="number" class="form-control" id="articant" name="articant" value="1">
                                        </div>
                                    </div>    
                                    <div class="row">
                                        <div class="col-sm-4">
                                            <label>Total</label>
                                            <input type="number" class="form-control" id="total" readonly>
                                        </div>
                                    </div>    
                                </div>
                            </div>
                            <div class="row py-1">
                                <div class="col-sm-12">
                                    <h4>Descripcion de Producto</h4>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12 text-justify" id="desc">

                                </div>
                            </div>
                    </div>
                    </form>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        <%if (flagsession) { %>
                        <button type="submit" id="btn_agregar" form="InsCarrito" class="btn btn-success" >Agregar al carrito</button>
                        <%} else {%>
                        <a class="btn btn-success" href="login_user.jsp">Agregar al Carrito</a>
                        <%}%>
                    </div>
                </div>
            </div>
        </div>
        <!-- Fin Modal Detalles -->
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
        <script src="resourse/js/script.market.js"></script>
        <script src="resourse/bootstrap/js/bootstrap.js"></script>
    </body>
</html>