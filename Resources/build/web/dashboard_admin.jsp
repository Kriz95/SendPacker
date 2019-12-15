<%@page import="java.util.ArrayList" %>
<%@ page import="DAO.ListarProv" %>
<%@ page import="DAO.ListarUsuarios" %>
<%@ page import="DAO.ListarVentas" %>
<%@ page import="java.util.List" %>
<%@ page import="Modelo.*" %>
<%@ page import="DAO.ListarArticulos" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page session="true" %>
<%
    HttpSession Session = request.getSession(false);
    if (Session.getAttribute("usuario") == null) {
        request.getRequestDispatcher("login_prov.jsp").forward(request, response);
    } else {
        ListarProv objP = new ListarProv();
        ListarUsuarios objU = new ListarUsuarios();
        ListarVentas objV = new ListarVentas();
        ListarArticulos objA = new ListarArticulos();
        Proveedor_V objProveedor = (Proveedor_V) Session.getAttribute("usuario");
        ArrayList<Proveedor_V> objListaPV = null;
        ArrayList<Proveedor_E> objListaPE = null;
        ArrayList<Usuarios> objListaU = null;
        List<Ventas> objListaV = null;
        List<Articulos> objListaA = null;
        List<String> objCate = null;
        if (request.getAttribute("filter_PV") == null) {
            objListaPV = objP.ListarProveedor_V("");
        } else {
            objListaPV = (ArrayList<Proveedor_V>) request.getAttribute("filter_PV");
        }
        if (request.getAttribute("filter_PE") == null) {
            objListaPE = objP.ListarProveedor_E("");
        } else {
            objListaPE = (ArrayList<Proveedor_E>) request.getAttribute("filter_PE");
        }
        if (request.getAttribute("filter_U") == null) {
            objListaU = objU.ListarUsuarios("");
        } else {
            objListaU = (ArrayList<Usuarios>) request.getAttribute("filter_U");
        }
        if (request.getAttribute("filter_A") == null) {
            objListaA = objA.ListarArticulosAdmin("");
        } else {
            objListaA = (List<Articulos>) request.getAttribute("filter_A");
        }
        if(request.getAttribute("filter_V") == null){
            objListaV = objV.ListarVentas("");
        }else{
            objListaV = (List<Ventas>)request.getAttribute("filter_V");
        }
        
        objCate = objA.Lista_Categorias();


%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Dashboard</title>
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
        <link rel="stylesheet" href="resourse/css/style.default.css" id="theme-stylesheet">
        <!-- Custom stylesheet - for your changes-->
        <!-- Favicon-->
        <link rel="shortcut icon" href="resourse/img/favicon.ico">
        <!-- Tweaks for older IEs--><!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
        <script src="resourse/jquery/jquery.js" type="text/javascript"></script>
        <script src="resourse/js/main.js"></script>
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
                        <h2 class="h5"><%= objProveedor.getRazon()%>
                        </h2><span>Desarrollador Web</span>
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
                           href="#prov_ventas"> <i class="icon-home"></i>Proveedores de Ventas</a></li>
                        <a class="list-group-item list-group-item-action " data-toggle="list" role="tab" href="#prov_envios"> <i
                                class="fas fa-chart-bar"></i>Proveedor de Envios</a>
                        <a class="list-group-item list-group-item-action " data-toggle="list" role="tab" href="#consu"><i
                                class="icon-grid"></i>Consumidores</a>
                        <a class="list-group-item list-group-item-action " data-toggle="list" role="tab" href="#ventas"><i
                                class="icon-grid"></i>Ventas</a>
                        <a class="list-group-item list-group-item-action " data-toggle="list" role="tab" href="#articulos"><i
                                class="icon-grid"></i>Articulos</a>
                    </div>
                    </ul>

                </div>
            </div>
        </nav>
        <input type="hidden" name="op" id="op" value=""/>
        <div class="page">
            <!-- navbar-->
            <header class="header">
                <nav class="navbar">
                    <div class="container-fluid">
                        <div class="navbar-holder d-flex align-items-center justify-content-between">
                            <div class="navbar-header"><a id="toggle-btn" href="#" class="menu-btn"><i
                                        class="icon-bars"></i></a><a href="#" class="navbar-brand">
                                    <div class="brand-text d-none d-md-inline-block">
                                        <strong class="text-primary">Dashboard Administrador</strong></div>
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
                    <div class="tab-pane fade show active" id="prov_ventas" role="tabpanel">
                        <div class="row my-2">
                            <div class="col-sm-12">
                                <h2 class="text-primary text-center">Control de Proveedores (Ventas)</h2></div>
                        </div>
                        <form name="filter_PV" action="ValLogin" method="POST">
                            <input type="hidden" name="op" value="28"/>
                            <div class="form-row">
                                <div class="col-sm-3 my-1 mx-2">
                                    <input class="form-control" type="number" name="search_PV" placeholder="Ingrese RUC">
                                </div>
                                <div class="col-sm-auto my-1 mx-2">
                                    <button type="submit" class="btn btn-block btn-primary">Buscar</button>
                                </div>
                            </div>
                        </form>
                        <div class="row my-2 mx-2">
                            <table class="table table-responsive-sm table-bordered">
                                <thead class="thead-dark">
                                <th style="width: 200px">RUC</th>
                                <th>Empresa</th>
                                <th>Fecha Registro</th>
                                <th>Ultima Modificacion</th>
                                <th>Estado</th>
                                <th style="width: 280px">Accion</th>
                                </thead>
                                <% for (int i = 0; i < objListaPV.size(); i++) {%>
                                <tr>
                                    <th><%= objListaPV.get(i).getRuc()%>
                                    </th>
                                    <td><%= objListaPV.get(i).getRazon()%>
                                    </td>
                                    <td><%= objListaPV.get(i).getF_reg()%>
                                    </td>
                                    <td><%if (objListaPV.get(i).getF_mod() == null) {%>
                                        No Modificado
                                        <%} else {%><%=objListaPV.get(i).getF_mod()%><%}%>
                                    </td>
                                    <td><% if (objListaPV.get(i).getEstado() == 0) {%>
                                        Inactivo
                                        <%} else { %>
                                        Activo<% }%></td>
                                    <td><% if (objListaPV.get(i).getEstado() == 1) {%>
                                        <button class="btn btn-danger" type="button"
                                                id="<%= objListaPV.get(i).getRuc()%>_eli_v" name="eli_v"
                                                data-toggle="modal" data-target="#modal_eli_prov_v"><i
                                                class="fas fa-ban"></i> Deshabilitar
                                        </button>
                                        <%}%>

                                        <button class="btn btn-success" id="<%= objListaPV.get(i).getRuc()%>_mod_v"
                                                name="mod_v" type="button" data-toggle="modal"
                                                data-target="#modal_mod_ventas"><i class="fas fa-edit"></i>Modificar
                                        </button>
                                    </td>
                                </tr>
                                <%} %>
                            </table>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="prov_envios" role="tabpanel">
                        <div class="row my-2">
                            <div class="col-sm-12">
                                <h2 class="text-primary text-center">Control de Proveedores (Envios)</h2></div>
                        </div>
                        <form name="filter_PE" action="ValLogin" method="POST">
                            <input type="hidden" name="op" value="29"/>
                            <div class="form-row">
                                <div class="col-sm-3 my-1 mx-2">
                                    <input class="form-control" name="search_PE" type="number" placeholder="Ingrese RUC">
                                </div>
                                <div class="col-sm-auto my-1 mx-2">
                                    <button type="submit" class="btn btn-block btn-primary">Buscar</button>
                                </div>
                            </div>
                        </form>
                        <div class="row my-2 mx-2">
                            <table class="table table-responsive-sm table-bordered">
                                <thead class="thead-dark">
                                <th style="width: 200px">RUC</th>
                                <th>Empresa</th>
                                <th>Horario</th>
                                </th>
                                <th>Fecha de Registro</th>
                                </th>
                                <th>Ultima Modificacion</th>
                                <th>Estado</th>
                                <th style="width: 280px">Accion</th>
                                </thead>
                                <% for (int i = 0; i < objListaPE.size(); i++) {%>
                                <tr>
                                    <th><%= objListaPE.get(i).getRuc()%>
                                    </th>
                                    <td><%= objListaPE.get(i).getRazon()%>
                                    </td>
                                    <td><%= objListaPE.get(i).getHini()%> - <%= objListaPE.get(i).getHfin()%>
                                    </td>
                                    <td><%= objListaPE.get(i).getF_reg()%>
                                    </td>
                                    <td><% if (objListaPE.get(i).getF_mod() == null) {%>
                                        No Modificado
                                        <%} else {%><%= objListaPE.get(i).getF_mod()%><%}%>
                                    </td>
                                    <td><% if (objListaPE.get(i).getEstado() == 0) {%>
                                        Inactivo
                                        <%} else { %>
                                        Activo<% }%>
                                    </td>
                                    <td><%if (objListaPE.get(i).getEstado() == 1) {%>
                                        <button class="btn btn-danger" type="button"
                                                id="<%= objListaPE.get(i).getRuc()%>_eli_e" name="eli_e"
                                                data-toggle="modal" data-target="#modal_eli_prov_e"><i
                                                class="fas fa-ban"></i> Deshabilitar
                                        </button>
                                        <%}%>
                                        <button class="btn btn-success" type="button"
                                                id="<%= objListaPE.get(i).getRuc()%>_mod_e" name="mod_e"
                                                data-toggle="modal" data-target="#modal_mod_envios"><i
                                                class="fas fa-edit"></i>Modificar
                                        </button>
                                    </td>
                                </tr>
                                <%} %>
                            </table>
                        </div>

                    </div>
                    <div class="tab-pane fade" id="consu" role="tabpanel">
                        <div class="row my-2">
                            <div class="col-sm-12">
                                <h2 class="text-primary text-center">Control de Consumidores</h2></div>
                        </div>
                        <form name="filter_U" method="POST" action="ValLogin">
                            <input name="op" type="hidden" value="30"/>
                            <div class="form-row">
                                <div class="col-sm-3 my-1 mx-2">
                                    <input class="form-control" name="search_U" type="number" placeholder="Ingrese DNI">
                                </div>
                                <div class="col-sm-auto my-1 mx-2">
                                    <button type="submit" class="btn btn-block btn-primary">Buscar</button>
                                </div>
                            </div>
                        </form>
                        <div class="row my-2 mx-2">
                            <table class="table table-responsive-sm table-bordered">
                                <thead class="thead-dark">
                                <th style="width: 200px">DNI</th>
                                <th>Nombres</th>
                                <th>Apell. Pat.</th>
                                <th>Apell. Mat.</th>
                                <th>Fecha Registro</th>
                                <th>Ult. Mod</th>
                                <th>Estado</th>
                                <th style="width: 280px">Accion</th>
                                </thead>
                                <% for (int i = 0; i < objListaU.size(); i++) {%>
                                <tr>
                                    <th><%= objListaU.get(i).getDNI()%>
                                    </th>
                                    <td><%= objListaU.get(i).getNombres()%>
                                    </td>
                                    <td><%= objListaU.get(i).getApelPaterno()%>
                                    </td>
                                    <td><%= objListaU.get(i).getApelMaterno()%>
                                    </td>
                                    <td><%= objListaU.get(i).getF_reg()%>
                                    </td>
                                    <td><%if (objListaU.get(i).getF_mod() == null) {%>
                                        No Modificado
                                        <%} else {%>
                                        <%=objListaU.get(i).getF_mod()%>
                                        <%}%>
                                    </td>
                                    <td><% if (objListaU.get(i).getEstado() == 0) {%>
                                        Inactivo
                                        <%} else { %>
                                        Activo<% }%>
                                    </td>
                                    <td><%if (objListaU.get(i).getEstado() == 1) {%>
                                        <button class="btn btn-danger" type="button"
                                                id="<%= objListaU.get(i).getDNI()%>_eli_u" name="eli_u"
                                                data-toggle="modal" data-target="#modal_eli_u"><i
                                                class="fas fa-ban"></i> Deshabilitar
                                        </button>
                                        <%}%>
                                        <button class="btn btn-success" type="button"
                                                id="<%= objListaU.get(i).getDNI()%>_mod_u" name="mod_u"
                                                data-toggle="modal" data-target="#modal_mod_u"><i
                                                class="fas fa-edit"></i>Modificar
                                        </button>
                                    </td>
                                </tr>
                                <%} %>
                            </table>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="ventas" role="tabpanel">
                        <div class="row my-2">
                            <div class="col-sm-12">
                                <h2 class="text-primary text-center">Control de Ventas</h2></div>
                        </div>
                        <form method="POST" action="ValLogin">
                            <input type="hidden" name="op" value="32"/>
                            <div class="form-row">
                                <div class="col-sm-3 my-1 mx-2">
                                    <input class="form-control" type="text" name="search_v" placeholder="Ingrese Codigo">
                                </div>
                                <div class="col-sm-auto my-1 mx-2">
                                    <button type="submit" class="btn btn-block btn-primary">Buscar</button>
                                </div>
                            </div>
                        </form>
                        <div class="row my-2 mx-2">
                            <table class="table table-responsive-sm table-bordered">
                                <thead class="thead-dark">
                                <th>Codigo</th>
                                <th>Fecha</th>
                                <th>DNI</th>
                                <th>Nombre</th>
                                <th>Total</th>
                                <th>Estado</th>
                                <th style="width: 280px">Accion</th>
                                </thead>
                                <% for (int i = 0; i < objListaV.size(); i++) {%>
                                <tr>
                                    <th><%= objListaV.get(i).getCodv()%>
                                    </th>
                                    <td><%= objListaV.get(i).getFechav()%>
                                    </td>
                                    <td><%= objListaV.get(i).getDNI()%>
                                    </td>
                                    <td><%= objListaV.get(i).getNDNI()%>
                                    </td>
                                    <td><%= objListaV.get(i).getTotalV()%>
                                    </td>
                                    <td><% if (objListaV.get(i).getEstadoV() == 0) {%>
                                        Inactivo
                                        <%} else { %>
                                        Activo<% }%>
                                    </td>
                                    <td><%if (objListaV.get(i).getEstadoV() == 1) {%>
                                        <button class="btn btn-danger" type="button"
                                                id="btn_eli_venta_<%= objListaV.get(i).getCodv()%>" name="eli_venta"
                                                data-toggle="modal" data-target="#modal_eli_venta"><i
                                                class="fas fa-ban"></i> Deshabilitar
                                        </button>
                                        <%}%>
                                        <button class="btn btn-success" type="button"
                                                id="btn_mod_venta_<%= objListaV.get(i).getCodv()%>" name="mod_venta"
                                                data-toggle="modal" data-target="#modal_mod_venta"><i
                                                class="fas fa-edit"></i>Modificar
                                        </button>
                                        <button class="btn btn-warning" type="button"
                                                id="btn_deta_venta_<%= objListaV.get(i).getCodv()%>" name="deta_venta"
                                                data-toggle="modal" data-target="#modal_detaventa"><i
                                                class="fas fa-edit"></i>Detalles
                                        </button>
                                    </td>
                                </tr>
                                <%} %>
                            </table>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="articulos" role="tabpanel">
                        <div class="row my-2">
                            <div class="col-sm-12">
                                <h2 class="text-primary text-center">Control de Articulos</h2></div>
                        </div>
                        <form name="filter_arti" method="POST" action="ValLogin">
                            <input type="hidden" name="op" value="31"/>
                            <div class="form-row">
                                <div class="col-sm-3 my-1 mx-2">
                                    <input class="form-control" type="text" name="search_arti" placeholder="Ingrese Codigo">
                                </div>
                                <div class="col-sm-auto my-1 mx-2">
                                    <button type="" class="btn btn-block btn-primary">Buscar</button>
                                </div>
                            </div>
                        </form>
                        <div class="row my-2 mx-2">
                            <table class="table table-responsive-sm table-bordered">
                                <thead class="thead-dark">
                                <th>Codigo</th>
                                <th>Articulo</th>
                                <th>RUC Prov.</th>
                                <th>Proveedor</th>
                                <th>Fecha de Registro</th>
                                <th>Fecha de Modificacion</th>
                                <th>Estado</th>
                                <th style="width: 280px">Accion</th>
                                </thead>
                                <% for (int i = 0; i < objListaA.size(); i++) {%>
                                <tr>
                                    <th><%= objListaA.get(i).getCod()%>
                                    </th>
                                    <td><%= objListaA.get(i).getNom()%>
                                    </td>
                                    <td><%= objListaA.get(i).getPv_ruc()%>
                                    </td>
                                    <td><%= objListaA.get(i).getNom_pv_ruc()%>
                                    </td>
                                    <td><%= objListaA.get(i).getF_reg()%>
                                    </td>
                                    <td><% if (objListaA.get(i).getF_mod() == null) { %>
                                        No Modificado
                                        <%} else {%><%= objListaA.get(i).getF_mod()%><%}%>
                                    </td>
                                    <td><% if (objListaA.get(i).getArti_estado() == 0) {%>
                                        Inactivo
                                        <%} else { %>
                                        Activo<% }%>
                                    </td>
                                    <td><%if (objListaA.get(i).getArti_estado() == 1) {%>
                                        <button class="btn btn-danger" type="button"
                                                id="btn_eli_arti_<%= objListaA.get(i).getCod()%>" name="eli_arti"
                                                data-toggle="modal" data-target="#modal_eli_arti"><i
                                                class="fas fa-ban"></i> Deshabilitar
                                        </button>
                                        <%}%>
                                        <button class="btn btn-success" type="button"
                                                id="btn_mod_arti_<%= objListaA.get(i).getCod()%>" name="mod_arti"
                                                data-toggle="modal" data-target="#modal_mod_arti"><i
                                                class="fas fa-edit"></i>Modificar
                                        </button>
                                    </td>
                                </tr>
                                <%} %>
                            </table>
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
        <!--Modal Eiminar Ventas-->
        <div class="modal fade" id="modal_eli_prov_v" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Eliminar</h5>
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="ValLogin" method="POST" id="eli_ventas">
                            <input type="hidden" id="iruc" name="iruc"/>
                            Si Borra este Registro ya no se podra recuperar
                        </form>
                    </div>
                    <div class="modal-footer">

                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        <button type="submit" form="eli_ventas" id="modal_eli_v" class="btn btn-danger">Deshabilitar</button>

                    </div>
                </div>
            </div>
        </div>
        <!--Fin Modal Eliminar Ventas-->
        <!--Modal Modificar Ventas-->
        <div class="modal fade" id="modal_mod_ventas" tabindex="-1" aria-hidden="true">
            <div class='modal-dialog modal-lg ' role='document'>
                <div class='modal-content'>
                    <div class='modal-header'>
                        <h5 class='modal-title'>Modificar</h5>
                        <button type='button' class='close' data-dismiss='modal'>
                            <span aria-hidden='true'>&times;</span>
                        </button>
                    </div>
                    <div class='modal-body'>
                        <form action='ValLogin' id='form_modificar_v' method="POST">
                            <input name="type" value="admin" type="hidden"/>
                            <div class='form-row'>
                                <div class='col-sm-3 py-1'><input class='form-control' id="ruc_v" name="ruc_v" type='number'
                                                                  placeholder='RUC' readonly=""></div>
                                <div class='col-sm-9 py-1'><input class='form-control' id="razon_v" name="razon_v" type='text'
                                                                  placeholder='Empresa' required></div>
                            </div>
                            <div class='row py-1'>
                                <div class='col-sm-12'><input class='form-control' id="direc_v" name="direc_v" type='text'
                                                              placeholder='Direccion' required></div>
                            </div>
                            <div class='row py-1'>
                                <div class='col-sm-12'><input class='form-control' id="email_v" name="email_v" type='email'
                                                              placeholder='Correo Electronico' required></div>
                            </div>
                            <div class='form-row'>
                                <div class='col-sm-8 py-1'><input class='form-control' id="cont_v" name="cont_v" type='text'
                                                                  placeholder='Nombre de Contacto' required></div>
                                <div class='col-sm-4 py-1'><input class='form-control' id="ncont_v" name="ncont_v" type='tel'
                                                                  placeholder='Telefono/Celular' required></div>
                            </div>
                            <div class="form-row">
                                <div class="col-sm-6 py-1"><input class="form-control" id="long_v" name="long_v" type="text"
                                                                  placeholder="Longitud" readonly></div>
                                <div class="col-sm-6 py-1"><input class="form-control" id="lat_v" name="lat_v" type="text"
                                                                  placeholder="Latitud" readonly></div>
                            </div>
                            <div class="row px-3 py-2">
                                <div class="limitermap">
                                    <div id="map_v" class="map">
                                    </div>
                                </div>
                            </div>
                            <div class='form-row'>
                                <div class='col-sm-6 py-1'>
                                    <div class='form-control'>
                                        <label>Estado</label>
                                        <select class='custom-select' id="select_v" name="select_v">
                                            <option value='1'>Activo</option>
                                            <option value='0'>Inactivo</option>
                                        </select></div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class='modal-footer'>

                        <button type='button' class='btn btn-secondary' data-dismiss='modal'>Cerrar</button>
                        <button type='submit' id='modal_conf_v' form='form_modificar_v' class='btn btn-success'>Modificar
                        </button>

                    </div>
                </div>
            </div>
        </div>
        <!--Fin Modal Modificar Ventas-->

        <!--Modal Eliminar Envios-->
        <div class="modal fade" id="modal_eli_prov_e" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Eliminar</h5>
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Si Borra este Registro ya no se podra recuperar
                        <form action="ValLogin" method="POST" id="form_eli_PE">
                            <input type="hidden" id="iruc_e"/>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        <button type="submit" id="modal_eli_e" form="form_eli_PE" class="btn btn-danger">Deshabilitar</button>
                    </div>
                </div>
            </div>
        </div>
        <!--Fin Modal Eliminar Envios-->
        <!--Modal Modificar Envios-->
        <div class="modal fade" id="modal_mod_envios" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Modificar</h5>
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form action="ValLogin" method="POST" id="form_modificar_e">
                        <input name="type" value="admin" type="hidden"/>
                        <div class="modal-body">

                            <div class="form-row">
                                <div class="col-sm-3 py-1"><input class="form-control" id="ruc_e" name="ruc_e" type="number"
                                                                  placeholder="RUC" readonly></div>
                                <div class="col-sm-9 py-1"><input class="form-control" id="razon_e" name="razon_e" type="text"
                                                                  placeholder="Empresa" required></div>
                            </div>
                            <div class="row py-1">
                                <div class="col-sm-12"><input class="form-control" type="text" id="direc_e" name="direc_e"
                                                              placeholder="Direccion" required></div>
                            </div>
                            <div class="row py-1">
                                <div class="col-sm-12"><input class="form-control" type="email" id="email_e" name="email_e"
                                                              placeholder="Correo Electronico" required></div>
                            </div>
                            <div class="form-row">
                                <div class="col-sm-6 py-1"><input class="form-control" type="text" id="long_e" name="long_e"
                                                                  placeholder="Longitud" readonly></div>
                                <div class="col-sm-6 py-1"><input class="form-control" type="text" id="lat_e" name="lat_e"
                                                                  placeholder="Latitud" readonly></div>
                            </div>
                            <div class="row px-3 py-2">
                                <div class="limitermap">
                                    <div id="map_e" class="map">
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-sm-8 py-1"><input class="form-control" type="text" id="cont_e" name="cont_e"
                                                                  placeholder="Nombre de Contacto" required></div>
                                <div class="col-sm-4 py-1"><input class="form-control" type="tel" id="ncont_e" name="ncont_e"
                                                                  placeholder="Telefono/Celular" required></div>
                            </div>
                            <div class="form-row">
                                <div class="col-sm-6 py-1">
                                    <div class="form-control">
                                        <label>Estado</label>
                                        <select class="custom-select" id="select_e" name="select_e">
                                            <option value="1">Activo</option>
                                            <option value="0">Inactivo</option>
                                        </select></div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="py-1">
                                        <input class="form-control" type="datetime" placeholder="Hora de Inicio" id="hini_e"
                                               name="hini_e"
                                               required></div>
                                    <div class="py-1">
                                        <input class="form-control" type="datetime" placeholder="Hora de Cierre" id="hfin_e"
                                               name="hfin_e"
                                               required></div>
                                </div>
                            </div>


                        </div>
                        <div class="modal-footer">

                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                            <button type="submit" id="modal_conf_e" class="btn btn-success">Confirmar
                            </button>

                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!--Fin Modal Modificar Envios-->


        <!--Modal Eliminar Consumidor-->
        <div class="modal fade" id="modal_eli_u" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Eliminar</h5>
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Si Borra este Registro ya no se podra recuperar
                        <form action="ValLogin" method="POST" id="form_eli_u">
                            <input type="hidden" name="idni_u" id="idni_u"/>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        <button type="submit" form="form_eli_u" class="btn btn-danger">Deshabilitar</button>
                    </div>
                </div>
            </div>
        </div>
        <!--Fin Modal Eliminar Consumidores-->
        <!--Modal Modificar Consumidores-->
        <div class="modal fade" id="modal_mod_u" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Modificar</h5>
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form action="ValLogin" method="POST" id="form_mod_u">
                        <div class="modal-body">

                            <div class="form-row">
                                <div class="col-sm-3 py-1"><input class="form-control" id="dni_u" name="dni_u" type="number"
                                                                  placeholder="DNI" readonly=""></div>
                                <div class="col-sm-9 py-1"><input class="form-control" id="nom_u" name="nom_u" type="text"
                                                                  placeholder="Nombres" required></div>
                            </div>
                            <div class="form-row">
                                <div class="col-sm-6 py-1"><input class="form-control" id="app_u" name="app_u" type="text"
                                                                  placeholder="Apellido Pat." required></div>
                                <div class="col-sm-6 py-1"><input class="form-control" id="apm_u" name="apm_u" type="text"
                                                                  placeholder="Apellido Mat." required></div>
                            </div>
                            <div class="row py-1">
                                <div class="col-sm-12"><input class="form-control" id="email_u" name="email_u" type="email"
                                                              placeholder="Correo Electronico" required></div>
                            </div>
                            <div class="form-row">
                                <div class="col-sm-6 py-1">
                                    <div class="form-control">
                                        <label>Estado</label>
                                        <select class="custom-select" id="select_u" name="select_u">

                                            <option value="1">Activo</option>
                                            <option value="0">Inactivo</option>

                                        </select></div>
                                </div>
                                <div class="col-sm-6 py-1">
                                    <input class="form-control" id="cel_u" type="number" placeholder="Celular" name="cel_u"
                                           required></div>
                            </div>


                        </div>
                    </form>
                    <div class="modal-footer">

                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        <button type="submit" form="form_mod_u" class="btn btn-success">Confirmar
                        </button>

                    </div>

                </div>
            </div>
        </div>
        <!--Fin Modal Modificar Consumidores-->
        <!--Modal Deshabilitar Ventas-->
        <div class="modal fade" id="modal_eli_venta" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Deshabilitar</h5>
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="ValLogin" method="POST" id="eli_venta">
                            <input type="hidden" id="codv" name="codv"/>
                            Si Borra este Registro ya no se podra recuperar
                        </form>
                    </div>
                    <div class="modal-footer">

                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        <button type="submit" form="eli_venta" id="modal_desha_v" class="btn btn-danger">Deshabilitar</button>

                    </div>
                </div>
            </div>
        </div>
        <!--Fin Modal Deshabilitar Ventas-->
        <!--Modal Modificar Venta-->
        <div class="modal fade" id="modal_mod_venta" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Modificar</h5>
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form action="ValLogin" method="POST" id="form_mod_venta">
                        <div class="modal-body">

                            <div class="form-row">
                                <div class="col-sm-4 py-1"><input class="form-control" id="cod_v" name="cod_v" type="text"
                                                                  placeholder="Codigo" readonly></div>
                                <div class="col-sm-4 py-1"><input class="form-control" id="dni_v" name="dni_v" type="text"
                                                                  placeholder="DNI" required></div>
                                <div class="col-sm-4 py-1"><input class="form-control" id="fecha_v" name="fecha_v" type="date"
                                                                  placeholder="Fecha" required></div>
                            </div>
                            <div class="form-row">
                                <div class="col-sm-6 py-1"><input class="form-control" id="total_v" name="total_v" type="text"
                                                                  placeholder="Total" required></div>
                                <div class="col-sm-6 py-1"><select class="custom-select" id="estado_v" name="estado_v">
                                        <option value="0">Inactivo</option>
                                        <option value="1">Activo</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-sm-6 py-1"><input class="form-control" id="long_venta" name="long_venta"
                                                                  type="number"
                                                                  placeholder="Longitud" readonly></div>
                                <div class="col-sm-6 py-1"><input class="form-control" id="lati_venta" name="lati_venta"
                                                                  type="number"
                                                                  placeholder="Latitud" readonly></div>
                            </div>
                            <div class="row py-1">
                                <div class="col-sm-12">
                                    <div class="limitermap">
                                        <div id="map_ventas" class="map">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <div class="modal-footer">

                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        <button type="submit" form="form_mod_venta" class="btn btn-success">Confirmar
                        </button>

                    </div>

                </div>
            </div>
        </div>
        <!--Fin Modal Modificar Venta-->
        <!--Modal Detalle de Ventas-->
        <div class="modal fade" id="modal_detaventa" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Detalle de Venta</h5>
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div id="modal-body-deta" class="modal-body">

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
        <!--Fin Modal Detalle de Ventas-->
        <!--Modal Deshabilitar Articulos-->
        <div class="modal fade" id="modal_eli_arti" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Deshabilitar</h5>
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="ValLogin" method="POST" id="form_eli_arti">
                            <input type="hidden" id="codarti" name="codarti"/>
                            Si Borra este Registro ya no se podra recuperar
                        </form>
                    </div>
                    <div class="modal-footer">

                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        <button type="submit" form="form_eli_arti" class="btn btn-danger">Deshabilitar</button>

                    </div>
                </div>
            </div>
        </div>
        <!--Fin Modal Deshabilitar Articulos-->
        <!--Modal Modificar Articulos-->
        <div class="modal fade" id="modal_mod_arti" tabindex="-1" aria-hidden="true">
            <div class='modal-dialog modal-lg ' role='document'>
                <div class='modal-content'>
                    <div class='modal-header'>
                        <h5 class='modal-title'>Modificar Articulo</h5>
                        <button type='button' class='close' data-dismiss='modal'>
                            <span aria-hidden='true'>&times;</span>
                        </button>
                    </div>
                    <div class='modal-body'>
                        <form action='ServletImagen' id='form_mod_arti' method="POST" enctype="multipart/form-data">
                            <input type="hidden" value="admin" name="type"/>
                            <div class='form-row'>
                                <div class='col-sm-3 py-1'><input class='form-control' id="cod_arti" name="cod_arti" type='text'
                                                                  placeholder='Codigo'
                                                                  readonly></div>
                                <div class='col-sm-9 py-1'><input class='form-control' id="nom_arti" name="nom_arti" type='text'
                                                                  placeholder='Articulo' required></div>
                            </div>
                            <div class='form-row'>
                                <div class='col-sm-4 py-1'><input class='form-control' id="prec_arti" name="prec_arti"
                                                                  type='text'
                                                                  placeholder='Precio' required></div>
                                <div class='col-sm-4 py-1'><input class='form-control' id="cant_arti" name="cant_arti"
                                                                  type='text'
                                                                  placeholder='Cantidad' required></div>
                                <div class='col-sm-4 py-1'>
                                    <select id="cate_arti" name="cate_arti" class="custom-select">
                                        <% for (int i = 0; i < objCate.size() - 1; i++) {%>
                                        <option value="<%=objCate.get(i)%>"><%=objCate.get(i + 1)%>
                                        </option>
                                        <%
                                                i = i + 1;
                                            }
                                        %>
                                    </select>
                                </div>

                            </div>
                            <div class="row py-1">
                                <div class="col-sm-12">
                                    <textarea class="form-control" rows="5" placeholder="Descripcion"
                                              id="desc_arti" name="desc_arti"></textarea>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-sm-6">
                                    <div class="row py-1">
                                        <div class="col-sm-12">
                                            <strong>NOTA: Deje este espacio en blanco para no cambiar la imagen</strong> 
                                        </div>
                                    </div>
                                    <div class="row py-1">
                                        <div class="col-sm-12">
                                            <div class="custom-file">
                                                <input type="file" class="custom-file-input" id="carga_mod" name="carga_mod" >
                                                <label class="custom-file-label" id="nomfile_mod">Subir Imagen</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row py-1">
                                        <div class="col-sm-12">
                                            <select class="custom-select" id="est_arti" name="est_arti">
                                                <option value="0">Inactivo</option>
                                                <option value="1">Activo</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6 py-1 text-center" id="mod_thumbnail">
                                    <img class="img-fluid img-thumbnail" src="resourse/img/no-imagen.jpg" style="height: 220px; width:auto">
                                </div>
                            </div>

                        </form>
                    </div>
                    <div class='modal-footer'>
                        <button type='button' class='btn btn-secondary' data-dismiss='modal'>Cerrar</button>
                        <button type='submit' form='form_mod_arti' class='btn btn-success'>Modificar
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <!--Fin Modal Modificar Articulos-->
        <%if (request.getAttribute("error") != null) {%>
        <div class="alert alert-danger alert-dismissible fade show fixed-bottom col-lg-3" id="error_alert" role="alert">
            <strong id="error_msg"><%=request.getAttribute("error")%></strong>
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