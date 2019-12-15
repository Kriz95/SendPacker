<%@page import="java.util.List"%>
<%@page import="Modelo.CarritoCompras"%>
<%@page import="DAO.ListarVentas"%>
<%@page import="Modelo.Usuarios"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% HttpSession Session = request.getSession();
    if(Session.getAttribute("DatosUser")==null){
        request.getRequestDispatcher("login_user.jsp").forward(request, response);
    }else{
    Usuarios objUser = (Usuarios) Session.getAttribute("DatosUser");
    ListarVentas objListaV = new ListarVentas();
    List<CarritoCompras> objListaC = null;
    if (request.getAttribute("filter_buy") == null) {
        objListaC = objListaV.FiltrarComprasUser(String.valueOf(objUser.getDNI()), null, null);
    } else {
        objListaC = (List<CarritoCompras>) request.getAttribute("filter_buy");
    }
    List<String> objFiltro = objListaV.ListarMesesyAños(String.valueOf(objUser.getDNI()));
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Compras Realizadas</title>
        <link rel="shortcut icon" href="resourse/img/favicon.ico">
        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="resourse/font-awesome/css/fontawesome-all.css">
        <link rel="stylesheet" href="resourse/bootstrap/css/bootstrap.css" >
        <script src="resourse/jquery/jquery.js"></script>
        <script src="resourse/bootstrap/js/bootstrap.js"></script>  
    </head>
    <style>
        body{
            background-image: url(resourse/img/fondo-a003.jpg);
            background-repeat: no-repeat;
            background-size: cover;
            background-attachment: fixed;
        }

        .container-form{
            background: white;
            margin-top: 6em;
            margin-bottom: 4em;
            border-radius: 15px;
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
                            <li><a href="tienda.jsp">TIENDA</a></li>
                            <li class="dropdown">
                                <a class="dropdown-toggle" data-toggle="dropdown" href="#"><i class="fas fa-user-circle"></i> <%=objUser.getNombres().toUpperCase()%></a>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item" href="AccountUserEdit.jsp">MI CUENTA</a>
                                    <a class="dropdown-item" href="#">MIS COMPRAS</a>
                                    <a id="btn_cerrar_U" class="dropdown-item" href="#">CERRAR SESION</a>
                                </div>
                            </li>        
                        </ul>
                        <form action="ServletCliente" method="POST" id="CerrarU">
                            <input type="hidden" name="op" value="3"/> 
                        </form>
                    </div>
                </div>
            </nav>
        </header>
        <div class="container-fluid">
            <div class="row justify-content-center">
                <div class="col-sm-9">
                    <div class="container-form p-4">
                        <div class="row">
                            <div class="col-sm-12">
                                <h2 class="text-center" >Compras Realizadas</h2>
                                <hr></div>
                        </div>
                        <div class="form-row">
                            <div class="col-sm-3 py-1">
                                <form action="ServletCliente" method="POST" id="filter">
                                    <input type="hidden" name="op" value="11">
                                    <select class="custom-select" name="filter_month">
                                        <%for (int i = 0; i < objFiltro.size(); i++) {%>
                                        <option value="<%=objFiltro.get(i)%>"><%=objFiltro.get(i)%></option>       
                                        <%}%>
                                    </select>
                                </form>
                            </div>
                            <div class="col-sm-auto py-1">
                                <button type="submit" form="filter" class="btn btn-primary btn-block">Filtrar Mes</button>
                            </div>
                        </div>
                        <div class="row py-1">
                            <div class="col-sm-12">
                                <div class="table-responsive"> 
                                    <table class="table table-bordered">
                                        <thead class="thead-dark">
                                        <th>Cod. Compra</th>
                                        <th>Fecha</th>
                                        <th>Cod. Articulo</th>
                                        <th>Articulo</th>
                                        <th>Cantidad</th>
                                        <th>Precio</th>
                                        <th>Total</th>
                                        </thead>
                                        <% for (int i = 0; i < objListaC.size(); i++) {%>
                                        <tr>
                                            <td><%=objListaC.get(i).getCat()%></td>
                                            <td><%=objListaC.get(i).getF_reg()%></td>
                                            <td><%=objListaC.get(i).getCod()%></td>
                                            <td><%=objListaC.get(i).getNom()%></td>
                                            <td><%=objListaC.get(i).getCant()%></td>
                                            <td><%=objListaC.get(i).getPrec()%></td>
                                            <td><%=objListaC.get(i).getPrec() * objListaC.get(i).getCant()%></td>
                                        </tr><%}%>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            $(document).ready(function () {
                $("#btn_cerrar_U").click(function () {
                    $("#CerrarU").submit();
                });
            });
        </script>
    </body>
</html><%}%>