<%@page import="Modelo.Articulos" %>
<%@page import="java.util.ArrayList" %>
<%@page import="Modelo.Proveedor_V" %>
<%@ page import="DAO.ListarArticulos" %>
<%@ page import="DAO.DatoEstadistica" %>
<%@ page import="java.util.List" %>
<%@ page import="Modelo.CarritoCompras" %>
<%@ page import="DAO.ListarVentas" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%
    HttpSession Session = request.getSession(false);
    if (Session.getAttribute("usuario") == null) {
        request.getRequestDispatcher("login_prov.jsp").forward(request, response);
    } else {
        Proveedor_V objProv = (Proveedor_V) Session.getAttribute("usuario");
        ListarArticulos objListaA = new ListarArticulos();
        DatoEstadistica objDatoE = new DatoEstadistica();
        ListarVentas objListaV = new ListarVentas();
        ArrayList<String> selectAños = objDatoE.ListarAños(String.valueOf(objProv.getRuc()));
        List<String> objListaCate = objListaA.Lista_Categorias();
        ArrayList<Articulos> lista = null;
        List<CarritoCompras> objListaDeta = null;
        if (request.getAttribute("filter_arti") == null) {
            lista = objListaA.BuscarArticulos(objProv.getRuc(), "");
        } else {
            lista = (ArrayList<Articulos>) request.getAttribute("filter_arti");
        }
        if (request.getAttribute("filter_sell") == null) {
            objListaDeta = objListaV.BuscarDetaVentasProv(objProv.getRuc(), null, null);
        } else {
            objListaDeta = (List<CarritoCompras>) request.getAttribute("filter_sell");
        }
        List<String> objFilter = objListaV.ListarMesesyAñosProv(objProv.getRuc());
        List<String> objRanking = objDatoE.RankingMesPasado(String.valueOf(objProv.getRuc()));
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Dashboard Proveedores Ventas</title>
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
        <script src="resourse/js/main_prov.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>

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
        <input type="hidden" id="op" name="op"/>
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
                           href="#lista_arti"> <i class="icon-home"></i>Lista Articulos</a></li>
                        <a class="list-group-item list-group-item-action " id="ingre" data-toggle="list" role="tab"> <i
                                class="fas fa-chart-bar"></i>Ingresar Articulos</a>
                        <a class="list-group-item list-group-item-action " data-toggle="list" href="#ListVentas" role="tab"> <i
                                class="fas fa-chart-bar"></i>Ver Ventas</a>
                        <input id="id_modal" type="hidden" data-toggle="modal" data-target="#modal_ingre_arti">
                        <a href="#AñosEstadistica" aria-expanded="false" data-toggle="collapse"> <i
                                class="fas fa-chart-bar"></i>Generar Estadistica</a>
                        <ul id="AñosEstadistica" class="collapse list-unstyled ">
                            <% for (String listar : selectAños) {%>
                            <li>
                                <form action="ServletEstadistica" method="POST" id="<%=listar%>"><a name="form_año"
                                                                                                    id="a_<%=listar%>"><%=listar%><input
                                            name="select" type="hidden" value="<%=listar%>"/><input name="op" type="hidden"
                                            value="1"/></a></form>
                            </li>
                            <% } %>
                            <li>
                                <form action="ServletEstadistica" method="POST" id="form_todo"><a id="esta_todo">Todos los
                                        Años</a><input name="op" type="hidden" value="2"/></form>
                            </li>
                        </ul>
                        <a class="list-group-item list-group-item-action" data-toggle="list" href="#Ranking" role="tab"> <i
                                class="fas fa-chart-bar"></i>Ranking Mes Pasado</a>
                        <a class="list-group-item list-group-item-action" id="callChart" data-toggle="list" href="#Prediccion" role="tab"> <i
                                class="fas fa-chart-bar"></i>Pronostico Ventas</a>

                        <a class="list-group-item list-group-item-action" id="callmap" data-toggle="list" href="#Cuenta" role="tab"> <i
                                class="fas fa-chart-bar"></i>Cuenta de Prov</a>
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
                                        <strong class="text-success">Dashboard Proveedores Ventas</strong></div>
                                </a></div>
                            <ul class="nav-menu list-unstyled d-flex flex-md-row align-items-md-center">
                                <!-- Cerrar Sesion-->
                                <li class="nav-item">
                                    <form action="ValLogin" method="POST"><input type="hidden" value="1" name="op" id="val">
                                        <button class="btn" id="cerrar" type="submit"><span class="d-none d-sm-inline-block">Cerrar Sesion</span><i
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
                    <div class="tab-pane fade show active" id="lista_arti" role="tabpanel">
                        <div class="row my-2">
                            <div class="col-sm-12">
                                <h2 class="text-success text-center">Lista de Articulos</h2></div>
                        </div>
                        <form name="filter_arti" method="POST" action="ValLogin">
                            <input type="hidden" name="op" value="27"/>
                            <div class="form-row">
                                <div class="col-sm-3 my-1 mx-2">
                                    <input class="form-control" name="search_arti" type="text" placeholder="Ingrese Codigo"/>
                                </div>
                                <div class="col-sm-auto my-1 mx-2">
                                    <button type="submit" class="btn btn-block btn-primary">Buscar Codigo</button>
                                </div>
                            </div>
                        </form>
                        <div class="row my-2 mx-2">
                            <table class="table table-responsive-sm table-bordered">
                                <thead class="thead-dark">
                                <th style="width: 90px">Codigo</th>
                                <th>Nombre Articulos</th>
                                <th>Precio</th>
                                <th>Cantidad</th>
                                <th>Fecha Registro</th>
                                <th>Fecha Modificacion</th>
                                <th>Estado</th>
                                <th style="width: 280px">Acciones</th>
                                </thead>
                                <% for (Articulos listar : lista) {%>
                                <tr>
                                    <th><%=listar.getCod()%>
                                    </th>
                                    <td><%=listar.getNom()%>
                                    </td>
                                    <td><%=listar.getPrecio()%>
                                    </td>
                                    <td><%=listar.getCant()%>
                                    </td>
                                    <td><%=listar.getF_reg()%>
                                    </td>
                                    <td><% if (listar.getF_mod() == null) {%>
                                        No Modificado
                                        <%} else {%>
                                        <%=listar.getF_mod()%><%}%>
                                    </td>
                                    <td><% if (listar.getArti_estado() == 0) {%>
                                        Inactivo
                                        <%} else {%>
                                        Activo
                                        <%}%>
                                    </td>
                                    <td><%if (listar.getArti_estado() == 1) {%>
                                        <button class="btn btn-danger" type="button" name="btn_eli_arti"
                                                id="eli_<%=listar.getCod()%>" data-toggle="modal"
                                                data-target="#modal_eli_arti"><i class="fas fa-ban"></i> Deshabilitar
                                        </button>
                                        <%}%>
                                        <button class="btn btn-success" name="mod" id="mod_<%=listar.getCod()%>"
                                                type="button" data-toggle="modal" data-target="#modal_mod_arti"><i
                                                class="fas fa-edit"></i>Modificar
                                        </button>
                                    </td>
                                </tr>
                                <% }%>
                            </table>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="ListVentas" role="tabpanel">
                        <div class="row my-2">
                            <div class="col-sm-12">
                                <h2 class="text-success text-center">Lista de Ventas</h2></div>
                        </div>
                        <form name="filter" action="ValLogin" method="POST">
                            <div class="form-row">
                                <input type="hidden" value="26" name="op"/>
                                <div class="col-sm-3 my-1 mx-2">
                                    <select  class="custom-select" name="filter_sell" id="filter_sell">
                                        <%for (int i = 0; i < objFilter.size(); i++) {%>
                                        <option value="<%=objFilter.get(i)%>"><%=objFilter.get(i)%></option>
                                        <%}%>
                                    </select>
                                </div>
                                <div class="col-sm-auto my-1 mx-2">
                                    <button type="submit" class="btn btn-block btn-primary">Filtrar Mes</button>
                                </div>
                                <div class="col-sm-auto my-1 mx-2">
                                    <button type="button" id="report_v" class="btn btn-block btn-warning" data-toggle="modal" data-target="#modal_reporte">Generar Reporte</button>
                                </div>
                            </div>
                        </form>            
                        <div class="row my-2 mx-2">
                            <table class="table table-responsive-sm table-bordered">
                                <thead class="thead-dark">
                                <th style="width: 90px">C. Venta</th>
                                <th style="width: 90px">Codigo</th>
                                <th>Nombre Articulos</th>
                                <th>Precio</th>
                                <th>Cantidad</th>
                                <th>Fecha Realizada</th>
                                <th>Estado</th>
                                </thead>
                                <% for (CarritoCompras listar : objListaDeta) {%>
                                <tr>
                                    <th><%=listar.getDescrip()%>
                                    </th>
                                    <th><%=listar.getCod()%>
                                    </th>
                                    <td><%=listar.getNom()%>
                                    </td>
                                    <td><%=listar.getPrec()%>
                                    </td>
                                    <td><%=listar.getCant()%>
                                    </td>
                                    <td><%=listar.getF_reg()%>
                                    </td>
                                    <td><% if (listar.getArti_estado() == 1) {%>
                                        Activo
                                        <%} else {%>
                                        Inactivo<%}%>
                                    </td>
                                </tr>
                                <% }%>
                            </table>
                        </div>
                    </div>
                    <div class="tab-pane fade px-sm-5" id="Ranking" role="tabpanel">
                        <div class="row my-2">
                            <div class="col-sm-12">
                                <h2 class="text-success text-center">Ranking del Mes Pasado</h2></div>
                        </div>  
                        <div class="row my-2 mx-2">
                            <table class="table table-responsive-sm table-bordered">
                                <thead class="thead-dark">
                                <th>N°</th>
                                <th style="width: 90px">Codigo</th>
                                <th>Articulo</th>
                                <th>Cantidad de Ventas</th>
                                </thead>
                                <%int a = 3;
                                    int j = 0;
                                    while (a < objRanking.size() && a < 18) {%>
                                <tr>
                                    <th><%=j = j + 1%></th>
                                    <td><%=objRanking.get(a - 3)%>
                                    </td>
                                    <td><%=objRanking.get(a - 2)%>
                                    </td>
                                    <td><%=objRanking.get(a - 1)%></td>
                                </tr><%a = a + 3;
                                    }%>
                            </table>
                        </div>
                    </div>
                    <div class="tab-pane fade px-sm-5" id="Prediccion" role="tabpanel">
                        <div class="row my-2">
                            <div class="col-sm-12">
                                <h2 class="text-success text-center">Pronostico de Ganancias por Articulo</h2></div>
                        </div>  
                        <div class="row">
                            <div class="chart-container">
                                <canvas id="myChart"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade px-sm-5" id="Cuenta" role="tabpanel">
                        <div class="row my-2">
                            <div class="col-sm-12">
                                <h2 class="text-success text-center">Datos de Proveedor</h2></div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <form action='ValLogin' id='form_modificar_v' method="POST">
                                    <input type="hidden" name="op" value="6"/>
                                    <input type="hidden" name="type" value="prov"/>
                                    <div class='form-row'>
                                        <div class='col-sm-3 py-1'><input class='form-control' id="ruc_v" value="<%=objProv.getRuc()%>" name="ruc_v" type='number'
                                                                          placeholder='RUC' readonly></div>
                                        <div class='col-sm-9 py-1'><input class='form-control' id="razon_v" name="razon_v" value="<%=objProv.getRazon()%>" type='text'
                                                                          placeholder='Empresa' required></div>
                                    </div>
                                    <div class='row py-1'>
                                        <div class='col-sm-12'><input class='form-control' id="direc_v" name="direc_v" type='text' value="<%=objProv.getDireccion()%>"
                                                                      placeholder='Direccion' required></div>
                                    </div>
                                    <div class='row py-1'>
                                        <div class='col-sm-12'><input class='form-control' id="email_v" name="email_v" type='email' value="<%=objProv.getEmail()%>"
                                                                      placeholder='Correo Electronico' required></div>
                                    </div>
                                    <div class='form-row'>
                                        <div class='col-sm-8 py-1'><input class='form-control' id="cont_v" name="cont_v" type='text' value="<%=objProv.getContacto()%>"
                                                                          placeholder='Nombre de Contacto' required></div>
                                        <div class='col-sm-4 py-1'><input class='form-control' id="ncont_v" name="ncont_v" type='tel' value="<%=objProv.getNContacto()%>"
                                                                          placeholder='Telefono/Celular' required></div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-sm-6 py-1"><input class="form-control" id="long_v" name="long_v" type="text" value="<%=objProv.getLong()%>"
                                                                          placeholder="Longitud" readonly></div>
                                        <div class="col-sm-6 py-1"><input class="form-control" id="lat_v" name="lat_v" type="text" value="<%=objProv.getLati()%>"
                                                                          placeholder="Latitud" readonly></div>
                                    </div>
                                    <div class="row px-3 py-2">
                                        <div class="limitermap">
                                            <div id="map_v" class="map">
                                            </div>
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
                        <div class="row pt-5">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <h2 class="text-success text-center">Cambiar Contraseña</h2>
                                    </div>
                                </div>
                                <form method="POST" action="ValLogin" id="mod_pass">
                                    <input type="hidden" value="25" name="op"/>
                                    <input type="hidden" value="prov_v" name="type"/>
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
        <!--Modal Eiminar Articulos-->
        <div class="modal fade" id="modal_eli_arti" tabindex="-1" aria-hidden="true">
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
                        <form id="form_desha_arti" action="ValLogin" method="POST">
                            <input type="hidden" id="codarti" name="codarti"/>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        <button type="submit" form="form_desha_arti" class="btn btn-danger">Deshabilitar</button>
                    </div>
                </div>
            </div>
        </div>
        <!--Fin Modal Eliminar Articulos-->
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
                        <form action='ServletImagen' id='form_modificar' method="POST" enctype="multipart/form-data">
                            <input type="hidden" name="typemod" value="prov"/>
                            <div class='form-row'>
                                <div class='col-sm-3 py-1'><input class='form-control' id="cod" name="cod_arti" type='text'
                                                                  placeholder='Codigo'
                                                                  readonly></div>
                                <div class='col-sm-9 py-1'><input class='form-control' id="nom" name="nom_arti" type='text'
                                                                  placeholder='Articulo' required></div>
                            </div>
                            <div class='form-row'>
                                <div class='col-sm-4 py-1'><input class='form-control' id="precio" name="prec_arti" type='text'
                                                                  placeholder='Precio' required></div>
                                <div class='col-sm-4 py-1'><input class='form-control' id="cant" name="cant_arti" type='text'
                                                                  placeholder='Cantidad' required></div>
                                <div class='col-sm-4 py-1'>
                                    <select id="cate" class="custom-select" name="cate_arti">
                                        <% for (int i = 0; i < objListaCate.size() - 1; i++) {%>
                                        <option value="<%=objListaCate.get(i)%>"><%=objListaCate.get(i + 1)%>
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
                                    <textarea class="form-control" rows="5" placeholder="Descripcion" name="desc_arti"
                                              id="desc_mod"></textarea>
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
                                            <select class="custom-select" id="est_mod" name="est_arti">
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
                        <button type='submit' form='form_modificar' class='btn btn-success'>Modificar</button>

                    </div>
                </div>
            </div>
        </div>
        <!--Fin Modal Modificar Articulos-->
        <!--Modal Ingresar Articulos-->
        <div class="modal fade" id="modal_ingre_arti" tabindex="-1" aria-hidden="true">
            <div class='modal-dialog modal-lg ' role='document'>
                <div class='modal-content'>
                    <div class='modal-header'>
                        <h5 class='modal-title'>Ingresar Articulo</h5>
                        <button type='button' class='close' data-dismiss='modal'>
                            <span aria-hidden='true'>&times;</span>
                        </button>
                    </div>
                    <div class='modal-body'>
                        <form action='ServletImagen' id='form_ingre' method="POST" class='form-group' enctype="multipart/form-data">
                            <input type="hidden" name="pv_ruc" value="<%=objProv.getRuc()%>" />
                            <div class='row py-1'>
                                <div class='col-sm-12 '><input class='form-control' id="nom_ingre" name="nom_ingre" type='text'
                                                               placeholder='Articulo' required></div>
                            </div>
                            <div class='form-row'>
                                <div class='col-sm-4 py-1'><input class='form-control' id="precio_ingre" name="precio_ingre" type='text'
                                                                  placeholder='Precio' required></div>
                                <div class='col-sm-4 py-1'><input class='form-control' id="cant_ingre" name="cant_ingre" type='text'
                                                                  placeholder='Cantidad' required></div>
                                <div class='col-sm-4 py-1'>
                                    <select id="cate_ingre" name="cate_ingre" class="custom-select">
                                        <% for (int i = 0; i < objListaCate.size() - 1; i++) {%>
                                        <option value="<%=objListaCate.get(i)%>"><%=objListaCate.get(i + 1)%>
                                        </option>
                                        <%
                                                i = i + 1;
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                            <div class="row py-1">
                                <div class="col-sm-12 ">
                                    <textarea class="form-control" rows="5" placeholder="Descripcion"
                                              id="desc_ingre" name="desc_ingre"></textarea>
                                </div>
                            </div>
                            <div class="form-row ">
                                <div class="col-sm-6 py-1">
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="carga" name="carga" required>
                                        <label class="custom-file-label" id="nomfile">Subir Imagen</label>
                                    </div>
                                </div>
                                <div class="col-sm-6 py-1 text-center" id="thumbnail">
                                    <img class="img-fluid img-thumbnail" src="resourse/img/no-imagen.jpg" style="height: 220px; width:auto" >
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class='modal-footer'>

                        <button type='button' class='btn btn-secondary' id="close_modal" data-dismiss='modal'>Cerrar</button>
                        <button type='submit' form="form_ingre" class='btn btn-warning'>Ingresar
                        </button>

                    </div>
                </div>
            </div>
        </div>
        <!--Fin Modal Ingresar Articulos-->
        <!--Modal Reporte-->
        <div class="modal fade" id="modal_reporte" tabindex="-1" aria-hidden="true">
            <div class='modal-dialog modal-lg ' role='document'>
                <div class='modal-content'>
                    <div class='modal-header'>
                        <h5 class='modal-title'>Reporte</h5>
                        <button type='button' class='close' data-dismiss='modal'>
                            <span aria-hidden='true'>&times;</span>
                        </button>
                    </div>
                    <div class='modal-body'>
                        <div class="row">
                            <div class="col-sm-12" id="graph-container">

                                <canvas id="oilChart" ></canvas>

                            </div>
                        </div>
                    </div>
                    <div class='modal-footer'>
                        <button type='button' class='btn btn-secondary' id="close_modal" data-dismiss='modal'>Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
        <!--Fin Modal Ingresar Articulos-->
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