<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Registro de Proveedor</title>
        <link rel="icon" type="image/icon" href="resourse/img/favicon.ico"/>
        <link href="resourse/css/main.css" type="text/css" rel="stylesheet">
        <link href="resourse/font-awesome/css/fontawesome-all.css" type="text/css" rel="stylesheet">
        <link rel="stylesheet" href="resourse/bootstrap/css/bootstrap.css" type="text/css"/>
        <link href="resourse/css/maps.css" rel="stylesheet" type="text/css">
        <script src="resourse/jquery/jquery.js"></script>

        <!------ Include the above in your HEAD tag ---------->
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
        <div class="limiter">
            <div class="container-regis100">
                <div class="wrap-regi100">
                    <form class="regi100-form validate-form" action="ValLogin" method="POST" id="form_reg" >
                        <input type="hidden" value="2" name="op"/>
                        <span class="login100-form-title">
                            Registro de Proveedores 
                        </span>
                        <div class="form-row">
                            <div class="col-xl-6 col-sm-6 col-md-6 ">
                                <div class="wrap-input100 validate-input" data-validate="Ingrese Ruc Valido">
                                    <input type="text" name="prov_ruc" id="prov_ruc" class="input100" placeholder="RUC"><span class="focus-input200"></span><span class="symbol-input100"><i class="fas fa-id-badge"></i></span>
                                </div>
                            </div>
                            <div class="col-xl-6 col-sm-6 col-md-6 ">
                                <div class="wrap-input100" data-validate="Ingrese Rubro">
                                    <select class="input100" name="tprov" id="tprov">
                                        <option value="-1" selected="" >Tipo de Prov.</option>
                                        <option value="1">Ventas</option>
                                        <option value="2">Envios</option>
                                    </select><span class="focus-input200"></span><span class="symbol-input100"><i class="fas fa-id-badge"></i></span>
                                </div>
                            </div>
                        </div>

                        <div class="wrap-input100 validate-input" data-validate="Rellene el Campo">
                            <input type="text" name="prov_razon" id="prov_razon" class="input100" placeholder="Razon Social"><span class="focus-input200"></span>
                            <span class="symbol-input100"><i class="fas fa-id-card" aria-hidden="true"></i></span>
                        </div>

                        <div class="wrap-input100 validate-input" data-validate="Rellene el Campo">
                            <input type="text" name="prov_dire" id="prov_dire" class="input100" placeholder="Direccion"><span class="focus-input200"></span>
                            <span class="symbol-input100"><i class="fas fa-id-card" aria-hidden="true"></i></span>
                        </div>
                        <div class="form-row" id="horarios">
                            <div class="col-xl-6 col-sm-6 col-md-6">
                                <div class="wrap-input100 " id="1" data-validate="Registre Horario de Apertura">
                                    <input type="time" name="prov_hini" id="prov_hini" class="" placeholder="Horario de Apertura"><span class="focus-input200"></span>
                                    <span class="symbol-input100"><i class="fas fa-id-card" aria-hidden="true"></i></span>
                                </div>
                            </div>
                            <div class="col-xl-6 col-sm-6 col-md-6">
                                <div class="wrap-input100 " id="2" data-validate="Registre Horario de Cierre">
                                    <input type="time" name="prov_hfin" id="prov_hfin" class="" placeholder="Horario de Cierre"><span class="focus-input200"></span>
                                    <span class="symbol-input100"><i class="fas fa-id-card" aria-hidden="true"></i></span>
                                </div>
                            </div>
                        </div>       
                        <div class="form-row">
                            <div class="col-xl-6 col-sm-6 col-md-6">
                                <div class="wrap-input100 validate-input" data-validate="Rellene el Campo">
                                    <input type="text" name="prov_contac" id="prov_contac" class="input100" placeholder="Nombre de Contacto"><span class="focus-input200"></span>
                                    <span class="symbol-input100"><i class="fas fa-id-card" aria-hidden="true"></i></span>
                                </div>
                            </div>
                            <div class="col-xl-6 col-sm-6 col-md-6">
                                <div class="wrap-input100 validate-input" data-validate="Rellene el Campo">
                                    <input type="text" name="prov_contac_num" id="prov_contac_num" class="input100" placeholder="Telefono"><span class="focus-input200"></span>
                                    <span class="symbol-input100"><i class="fas fa-id-card" aria-hidden="true"></i></span>
                                </div>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="col-xl-4 col-sm-4 col-md-4">
                                <div class="wrap-input100 validate-input" data-validate="Rellene Campo">
                                    <input type="text" name="prov_Long" id="prov_Long" class="input100" placeholder="Longitud" readonly><span class="focus-input200"></span>
                                    <span class="symbol-input100"><i class="fas fa-id-card" aria-hidden="true"></i></span></div>
                            </div>
                            <div class="col-xl-4 col-sm-4 col-md-4">
                                <div class="wrap-input100 validate-input" data-validate="Rellene Campo">
                                    <input type="text" name="prov_Lat" id="prov_Lat" class="input100" placeholder="Latitud" readonly ><span class="focus-input200"></span>
                                    <span class="symbol-input100"><i class="fas fa-id-card" aria-hidden="true"></i></span></div>
                            </div>
                            <div class="col-xl-4 col-sm-4 col-md-4">
                                <div class="mb-2">
                                    <button class="login200-form-btn" type="button" data-toggle="modal" data-target="#modal_ubi">
                                        Señalar Ubicacion</button>
                                </div>
                            </div>
                        </div>

                        <div class="wrap-input100 validate-input" data-validate="Ingrese Correo Valido abc@xyz.123">
                            <input type="text" name="email" id="email" class="input100" placeholder="Direccion de Correo" >
                            <span class="focus-input200"></span>
                            <span class="symbol-input100"><i class="fas fa-at" aria-hidden="true"></i></span>
                        </div>

                        <div class="form-row">
                            <div class="col-xl-6 col-sm-6 col-md-6">
                                <div class="wrap-input100 validate-input" data-validate="Rellene el campo">
                                    <input type="password" name="password" id="password" class="input100" placeholder="Contraseña">
                                    <span class="focus-input200"></span><span class="symbol-input100"><i class="fas fa-lock" aria-hidden="true"></i></span>
                                </div>
                            </div>
                            <div class="col-xl-6 col-sm-6 col-md-6">
                                <div class="wrap-input100 validate-input" data-validate="Rellene el campo">
                                    <input type="password" name="password_confirmation" id="password_confirmation" class="input100" placeholder="Confirmar Contraseña">
                                    <span class="focus-input200"></span><span class="symbol-input100"><i class="fas fa-lock" aria-hidden="true"></i></span>
                                </div>
                            </div>
                        </div>
                        <div class="container-login200-form-btn">

                            <button class="login200-form-btn"  id="reg_btn" type="submit">
                                Registrar</button>
                        </div>
                        <div class="container-login200-form-btn">
                            <button class="login200-form-btn-reg" type="button" onclick="location.href = 'login_prov.jsp'">
                                Regresar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!--Modal Ubicacion-->
        <div class="modal fade" id="modal_ubi" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Señalar Ubicacion</h5>
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="limitermap">
                            <div id="map" class="map"></div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        <button type="button" id="modal_conf" class="btn btn-success" onclick="setLongLat()" data-dismiss="modal" disabled>Seleccionar</button>
                    </div>
                </div>
            </div>
        </div>
        <!--Fin Modal Ubicacion-->
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
        <script src="resourse/bootstrap/js/bootstrap.js"></script>
        <script src="resourse/js/main.js"></script>
        <script src="resourse/js/registro.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDcCBmYTSMPzTaZS7ISySW-iXUSKQyvKQY&callback=initMap"
        async defer></script>
    </body>
</html>