<%@page import="Modelo.Envios" %>
<%@page import="Modelo.Proveedor_E" %>
<%@ page import="DAO.ListarEnvios" %>
<%@ page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%
    HttpSession Session = request.getSession(false);
    if (Session.getAttribute("usuario") == null) {
        request.getRequestDispatcher("login_prov.jsp").forward(request, response);

    } else {
        ListarEnvios objListaE = new ListarEnvios();
        List<Envios> lista_mis = null;
        List<Envios> lista = null;
        Proveedor_E objProv = (Proveedor_E) Session.getAttribute("usuario");
        try {
            lista_mis = objListaE.ListarEnviosRuc(String.valueOf(objProv.getRuc()));
            lista = objListaE.ListarTodosEnvios();
        } catch (Exception e) {
            e.printStackTrace();
        }

%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Dashboard Proveedores Envios</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Bootstrap CSS-->
        <link rel="stylesheet" href="resourse/bootstrap/css/bootstrap.css">
        <!-- Font Awesome CSS-->
        <link rel="stylesheet" href="resourse/font-awesome/css/fontawesome-all.css">
        <!-- Fontastic Custom icon font-->
        <link rel="stylesheet" href="resourse/css/fontastic.css">
        <link rel="stylesheet" href="resourse/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.css">
        <link rel="stylesheet" href="resourse/css/maps.css">
        <!-- theme stylesheet-->
        <link rel="stylesheet" href="resourse/css/style.default.prov.css" id="theme-stylesheet">
        <!-- Custom stylesheet - for your changes-->
        <!-- Favicon-->
        <link rel="shortcut icon" href="resourse/img/favicon.ico">
        <!-- Tweaks for older IEs--><!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->   
        <script src="resourse/jquery/jquery.js" type="text/javascript"></script>
        <script src="resourse/js/main_prov.js" type="text/javascript"/></script>
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
    <!-- Side Navbar -->
    <nav class="side-navbar mCustomScrollbar">
        <div class="side-navbar-wrapper">
            <!-- Sidebar Header    -->
            <div class="sidenav-header d-flex align-items-center justify-content-center">
                <!-- Informacion de Usuario-->
                <div class="sidenav-header-inner text-center">
                    <h2 class="h5"><%= objProv.getRazon()%>
                    </h2><span>Proveedor</span>
                </div>
                <!-- Small Brand information, appears on minimized sidebar-->
                <div class="sidenav-header-logo"><a href="#"
                                                    class="brand-small text-center"><strong>D</strong><strong>S</strong></a>
                </div>
            </div>
            <!-- Sidebar Navigation Menus-->
            <div class="main-menu">
                <h5 class="sidenav-heading">Menu</h5>
                <div class="list-group" id="list-tab" role="tablist">
                    <a class="list-group-item list-group-item-action active" data-toggle="list" role="tab"
                       href="#tabla_envios"> <i class="icon-home"></i>Tabla de Envios</a>
                    <a class="list-group-item list-group-item-action" data-toggle="list" role="tab" href="#tabla_misenvios">
                        <i class="icon-home"></i>Mis Envios</a>
                    <a class="list-group-item list-group-item-action" id="callmap2" data-toggle="list" role="tab" href="#Cuenta">
                        <i class="icon-home"></i>Cuenta de Prov</a>
                </div>
            </div>
        </div>
    </nav>
    <div class="page">
        <!-- navbar-->
        <header class="header">
            <nav class="navbar">
                <div class="container-fluid">
                    <div class="navbar-holder d-flex align-items-center justify-content-between">
                        <div class="navbar-header"><a id="toggle-btn" href="#" class="menu-btn"><i
                                    class="icon-bars"></i></a><a href="#" class="navbar-brand">
                                <div class="brand-text d-none d-md-inline-block">
                                    <strong class="text-success">Dashboard Proveedores Envios</strong></div>
                            </a></div>
                        <ul class="nav-menu list-unstyled d-flex flex-md-row align-items-md-center">
                            <!-- Cerrar Sesion-->
                            <li class="nav-item">
                                <form action="ValLogin" method="POST"><input type="hidden" value="1" name="op" id="val">
                                    <button class="btn"><span class="d-none d-sm-inline-block">Cerrar Sesion</span><i
                                            class="fas fa-sign-out-alt"></i></button>
                                </form>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>
        <div class="container-fluid">
            <div class="tab-content">
                <div class="tab-pane fade show active" id="tabla_envios" role="tabpanel">
                    <div class="row my-2">
                        <div class="col-sm-12">
                            <h2 class="text-success text-center">Envios por Realizar</h2></div>
                    </div>

                    <div class="row my-2 mx-2">
                        <table class="table table-responsive-sm table-bordered">
                            <thead class="thead-dark">
                            <th>Articulo</th>
                            <th>Usuario</th>
                            <th>Nombre</th>
                            <th>Fecha Registro</th>
                            <th>Estado</th>
                            <th style="width: 150px">Accion</th>
                            </thead>
                            <%for (int i = 0; i < lista.size(); i++) {%>
                            <tr>
                                <td><%=lista.get(i).getArticulo()%>
                                </td>
                                <td><%=lista.get(i).getDni()%>
                                </td>
                                <td><%=lista.get(i).getNom()%>
                                </td>
                                <td><%=lista.get(i).getFecha()%>
                                </td>
                                <td><% if (lista.get(i).getEstado() == 0) {%>
                                    No Enviado
                                    <%} else { %>
                                    Enviado<% }%>
                                </td>
                                <td>
                                    <div class="list-inline">
                                        <div class="list-inline-item">
                                            <button class="btn btn-danger" name="tomar_e"
                                                    id="tomar_<%=lista.get(i).getCventa()%>_<%=lista.get(i).getCarti()%>"
                                                    type="button"
                                                    data-toggle="modal" data-target="#modal_tomar"><i
                                                    class="fas fa-edit"></i> Tomar Envio
                                            </button>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <% } %>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="tabla_misenvios" role="tabpanel">
                    <div class="row my-2">
                        <div class="col-sm-12">
                            <h2 class="text-success text-center">Mis Envios</h2></div>
                    </div>

                    <div class="row my-2 mx-2">
                        <table class="table table-responsive-sm table-bordered">
                            <thead class="thead-dark">
                            <th>Articulo</th>
                            <th>Usuario</th>
                            <th>Nombre</th>
                            <th>Fecha Registro</th>
                            <th>Estado</th>
                            <th style="width: 150px">Accion</th>
                            </thead>
                            <%for (Envios listar : lista_mis) {%>
                            <tr>
                                <td><%=listar.getArticulo()%>
                                </td>
                                <td><%=listar.getDni()%>
                                </td>
                                <td><%=listar.getNom()%>
                                </td>
                                <td><%=listar.getFecha()%>
                                </td>
                                <td><% if (listar.getEstado() == 0) {%>
                                    Pendiente
                                    <%} else { %>
                                    Completado<% }%>
                                </td>
                                <td>
                                    <% if (listar.getEstado() == 0) {%>
                                    <button class="btn btn-warning" type="button" name="comple_e"
                                            id="comple_<%=listar.getCventa()%>_<%=listar.getCarti()%>"
                                            data-toggle="modal" data-target="#modal_comple"><i class="fas fa-ban"></i>
                                        Completado
                                    </button>
                                    <%}%>
                                    <form action="ValLogin" method="POST" id="<%=listar.getCventa()%><%=listar.getCarti()%>">
                                        <input type="hidden" name="Cventa" value="<%=listar.getCventa()%>"/>
                                        <input type="hidden" name="Carti" value="<%=listar.getCarti()%>"/>
                                        <button class="btn btn-info" type="button" name="btn_ruta" id="<%=listar.getCventa()%>_<%=listar.getCarti()%>"><i class="fas fa-ban"></i> Ruta
                                        </button>
                                    </form>
                                </td>
                            </tr>
                            <% }%>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade px-sm-5" id="Cuenta" role="tabpanel">
                    <div class="row my-2 ">
                        <div class="col-sm-12">
                            <h2 class="text-success text-center">Datos de Proveedor</h2></div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <form action="ValLogin" method="POST" id="form_modificar_e">
                                <input type="hidden" name="op" value="8"/>
                                <input type="hidden" name="type" value="prov"/>
                                <div class="form-row">
                                    <div class="col-sm-3 py-1"><input class="form-control" id="ruc_e" name="ruc_e" type="number" value="<%=objProv.getRuc()%>"
                                                                      placeholder="RUC" readonly></div>
                                    <div class="col-sm-9 py-1"><input class="form-control" id="razon_e" name="razon_e" type="text" value="<%=objProv.getRazon()%>"
                                                                      placeholder="Empresa" required></div>
                                </div>
                                <div class="row py-1">
                                    <div class="col-sm-12"><input class="form-control" type="text" id="direc_e" name="direc_e" value="<%=objProv.getDireccion()%>"
                                                                  placeholder="Direccion" required></div>
                                </div>
                                <div class="row py-1">
                                    <div class="col-sm-12"><input class="form-control" type="email" id="email_e" name="email_e" value="<%=objProv.getEmail()%>"
                                                                  placeholder="Correo Electronico" required></div>
                                </div>
                                <div class="form-row">
                                    <div class="col-sm-6 py-1"><input class="form-control" type="text" id="long_e" name="long_e" value="<%=objProv.getLong()%>"
                                                                      placeholder="Longitud" readonly></div>
                                    <div class="col-sm-6 py-1"><input class="form-control" type="text" id="lat_e" name="lat_e" value="<%=objProv.getLati()%>"
                                                                      placeholder="Latitud" readonly></div>
                                </div>
                                <div class="row px-3 py-2">
                                    <div class="limitermap">
                                        <div id="map_e" class="map">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="col-sm-8 py-1"><input class="form-control" type="text" id="cont_e" name="cont_e" value="<%=objProv.getContacto()%>"
                                                                      placeholder="Nombre de Contacto" required></div>
                                    <div class="col-sm-4 py-1"><input class="form-control" type="tel" id="ncont_e" name="ncont_e" value="<%=objProv.getNContacto()%>"
                                                                      placeholder="Telefono/Celular" required></div>
                                </div>
                                <div class="form-row">
                                    <div class="col-sm-6 py-1">
                                        <input class="form-control" type="datetime" placeholder="Hora de Inicio" id="hini_e" value="<%=objProv.getHini()%>"
                                               name="hini_e"
                                               required>
                                    </div>
                                    <div class="col-sm-6 py-1">
                                        <input class="form-control" type="datetime" placeholder="Hora de Cierre" id="hfin_e" value="<%=objProv.getHfin()%>"
                                               name="hfin_e"
                                               required>
                                    </div>
                                </div>
                                <div class="form-row justify-content-center">
                                    <div class="col-sm-3 py-1">
                                        <button type="submit" class="btn btn-success btn-block">Confirmar Cambios</button>
                                    </div>
                                    <div class="col-sm-3 py-1 pb-2">
                                        <button type="reset" class="btn btn-danger btn-block">Borra Todo</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="row pt-5 ">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-12">
                                    <h2 class="text-success text-center">Cambiar Contraseña</h2>
                                </div>
                            </div>
                            <form method="POST" action="ValLogin" id="mod_pass">
                                <input type="hidden" value="25" name="op"/>
                                <input type="hidden" value="prov_e" name="type"/>
                                <div class="form-row justify-content-center">
                                    <div class="col-sm-2 py-1">
                                        <label>Contraseña Antigua</label>
                                    </div>
                                    <div class="col-sm-3 py-1">
                                        <input class="form-control" type="password"  id="oldpass" name="oldpass" required>
                                    </div>
                                </div>
                                <div class="form-row justify-content-center">
                                    <div class="col-sm-2 py-1">
                                        <label>Contraseña Nueva</label>
                                    </div>
                                    <div class="col-sm-3 py-1">
                                        <input class="form-control" type="password"  id="newpass" name="newpass" required>
                                    </div>
                                </div>
                                <div class="form-row justify-content-center">
                                    <div class="col-sm-2 py-1">
                                        <label>Repetir Contraseña</label>
                                    </div>
                                    <div class="col-sm-3 py-1">
                                        <input class="form-control" type="password"  id="newpass2" required>
                                    </div>
                                </div>
                                <div class="form-row justify-content-center pb-2">
                                    <div class="col-sm-auto py-1">
                                        <button type="submit" class="btn btn-success btn-block">Confirmar</button>  
                                    </div>
                                    <div class="col-sm-auto py-1">
                                        <button type="reset" class="btn btn-danger btn-block">Borrar</button>    
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer class="main-footer">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-sm-6">
                        <p>UTP Developed &copy; 2017-2019</p>
                    </div>
                    <div class="col-sm-6 text-right">
                        <p>Design by <a href="https://bootstrapious.com" class="external">Bootstrapious</a></p>
                        <!-- Please do not remove the backlink to us unless you support further theme's development at https://bootstrapious.com/donate. It is part of the license conditions and it helps me to run Bootstrapious. Thank you for understanding :)-->
                    </div>
                </div>
            </div>
        </footer>
    </div>
    <!--Modal Completar Envio-->
    <div class="modal fade" id="modal_comple" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog " role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Completar</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="ValLogin" method="POST" id="form_complete">
                        <input type="hidden" id="id_v" name="id_v"/><input type="hidden" id="id_art" name="id_art"/>
                    </form>
                    Si marca como "Completado" este envio, ya no se podra cambiar
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    <button type="submit" form="form_complete" class="btn btn-success">Confirmar</button>
                </div>
            </div>
        </div>
    </div>
    <!--Fin Modal Completar Envio-->
    <!--Modal Toma Envio-->
    <div class="modal fade" id="modal_tomar" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Realizar Envio</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form id="form_tomar" action="ValLogin" method="POST">
                    <div class="modal-body">
                        <div class="form-row">
                            <div class="col-sm-1 py-1"><input class="form-control" id="codarti_en" name="codarti_en"
                                                              type="text"
                                                              placeholder="Articulo" readonly></div>
                            <div class="col-sm-10 py-1"><input class="form-control" id="arti_en" name="arti_en" type="text"
                                                               placeholder="Articulo" readonly></div>
                            <div class="col-sm-1 py-1"><input class="form-control" id="cant_en" type="number"
                                                              placeholder="Cantidad" readonly></div>
                        </div>
                        <div class="form-row">
                            <div class="col-sm-3 py-1"><input class="form-control" id="dni_en" type="text" placeholder="DNI"
                                                              readonly></div>
                            <div class="col-sm-9 py-1"><input class="form-control" id="nom_en" type="text"
                                                              placeholder="Nombre" readonly></div>
                        </div>
                        <div class="form-row">
                            <div class="col-sm-6 py-1"><input class="form-control" id="ruc_en" type="text" placeholder="RUC"
                                                              readonly></div>
                            <div class="col-sm-6 py-1"><input class="form-control" id="fecha_en" type="text"
                                                              placeholder="Fecha" readonly></div>
                        </div>

                        <div class="row py-1">
                            <div class="col-sm-12"><input class="form-control" id="razon_en" type="text" placeholder="Razon"
                                                          readonly></div>
                        </div>

                        <div class="row px-3 py-2">
                            <input type="hidden" name="lat_en" id="lat_en"/><input type="hidden" name="long_en"
                                                                                   id="long_en"/>
                            <input type="hidden" name="lat_pv" id="lat_pv"/><input type="hidden" name="long_pv"
                                                                                   id="long_pv"/>
                            <input type="hidden" id="op" name="op"/>
                            <input type="hidden" name="codvent" id="codvent"/>
                            <div class="limitermap">
                                <div id="map_entrega" class="map">
                                </div>
                            </div>
                        </div>
                        NOTA: Al Confirmar se le enviara la ruta a seguir
                    </div>
                </form>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    <button type="submit" form="form_tomar" class="btn btn-success">Confirmar</button>
                </div>
            </div>
        </div>
    </div>
    <!--Fin Modal Modificar Consumidores-->
    <%if (request.getAttribute("error") != null) {%>
    <div class="alert alert-danger alert-dismissible fade show fixed-bottom col-lg-3" id="error_alert" role="alert">
        <strong id="error_msg"><%=request.getAttribute("error")%></strong>
        <button type="button" class="close" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <%} else {%>
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
    <!-- JavaScript files-->

    <script src="resourse/popper.js/umd/popper.js"></script>
    <script src="resourse/bootstrap/js/bootstrap.js" type="text/javascript"></script>
    <script src="resourse/js/grasp_mobile_progress_circle-1.0.0.min.js"></script>
    <script src="resourse/jquery-validation/jquery.validate.min.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDcCBmYTSMPzTaZS7ISySW-iXUSKQyvKQY"></script>
    <!-- Main File-->
    <script src="resourse/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.js"></script>
    <script src="resourse/js/front.js"></script>
</body>
</html>
<% }%>