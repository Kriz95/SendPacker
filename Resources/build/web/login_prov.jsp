<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <title>Login</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <link rel="icon" type="image/icon" href="resourse/img/favicon.ico"/>
        <link rel="stylesheet" type="text/css" href="resourse/bootstrap/css/bootstrap.css"/>
        <link href="resourse/font-awesome/css/fontawesome-all.css" type="text/css" rel="stylesheet"/>
        <link rel="stylesheet" type="text/css" href="resourse/css/main.css"/>
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
            <div class="container-login100">
                <div class="wrap-login100">
                    <form class="login100-form validate-form" method="POST" action="ValLogin">
                        <span class="login100-form-title">
                            Ingreso de Proveedores
                        </span>

                        <div class="wrap-input100 validate-input" data-validate = "Ingrese un RUC valido">
                            <input class="input100" type="text" name="prov_ruc" placeholder="RUC" autocomplete="off">
                            <span class="focus-input100"></span>
                            <span class="symbol-input100">
                                <i class="fas fa-user" aria-hidden="true"></i>
                            </span>
                        </div>

                        <div class="wrap-input100 validate-input" data-validate = "Ingrese Contraseña Valida">
                            <input class="input100" type="password" name="pass" placeholder="Contraseña" autocomplete="off">
                            <span class="focus-input100"></span>
                            <span class="symbol-input100">
                                <i class="fas fa-lock" aria-hidden="true"></i>
                            </span>
                        </div>

                        <div class="container-login100-form-btn">
                            <input type="hidden" name="op" id="op" value="0">
                            <button class="login100-form-btn">
                                Ingresar
                            </button>
                        </div>
                        <div class="container-login100-form-btn">
                            <a class="login100-form-btn" href="index.jsp">
                                Menu Principal
                            </a>
                        </div>

                        <div class="text-center p-t-12">
                            <span class="txt1">
                                Olvidaste
                            </span>
                            <a class="txt2" href="#">
                                ID / Contraseña?
                            </a>
                        </div>

                        <div class="text-center p-t-136">
                            <a class="txt2" href="registroProv.jsp">
                                Crear Cuenta
                                <i class="fas fa-long-arrow-alt-right" aria-hidden="true"></i>
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
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
        <script src="resourse/jquery/jquery.js"></script>
        <script src="resourse/js/main.js"></script>
    </body>
</html>