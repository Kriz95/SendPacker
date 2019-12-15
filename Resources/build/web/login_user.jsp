<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plataforma de clientes</title>
        <link href="resourse/bootstrap/css/bootstrap.css" rel="stylesheet">
        <link rel="shortcut icon" href="resourse/img/favicon.ico">
        <link href="resourse/css/style.login.user.css" rel="stylesheet" type="text/css"/>
        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
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
        <div class="container-fluid" style="padding-top: 6%">
            <div class="row justify-content-center">
                <div class="col-sm-6">
                    <div class="panel-login p-3" >
                        <div class="panel-heading">
                            <div class="form-row">
                                <div class="col-sm-6">
                                    <a href="#" class="active" id="login-form-link">Inicio de sesión</a>
                                </div>
                                <div class="col-sm-6"> 
                                    <a href="#" id="register-form-link">Registro</a>
                                </div>
                            </div>
                            <hr>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-sm-12">
                                    <form id="login-form" action="ServletCliente" method="post" style="display: block;">
                                        <div class="row py-1">
                                            <div class="col-sm-12 ">
                                                <input type="number" name="txtdnicliente" id="txtdnicliente" class="form-control" placeholder="DNI" value="">
                                            </div>
                                        </div>
                                        <div class="row py-1">
                                            <div class="col-sm-12 ">
                                                <input type="password" name="txtclavecliente" id="txtclavecliente" class="form-control" placeholder="Contraseña">
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-sm-12 py-1">
                                                <button type="submit" name="btningresarcliente" id="btningresarcliente" class="btn btn-primary btn-block">Iniciar Sesion</button>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-12 py-1">
                                                <a class="btn btn-success btn-block" href="index.jsp">Menu Principal</a>
                                            </div>
                                        </div>
                                        <input type="hidden" name="op" value="1"/>
                                    </form>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <form id="register-form" action="ServletCliente" method="post" role="form" style="display: none;">
                                        <div class="row">
                                            <div class="col-sm-12 py-1">
                                                <input type="number" name="txtdniclientereg" id="txtdniclientereg" class="form-control" placeholder="DNI" required >
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-12 py-1">
                                                <input type="text" name="txtapellidopatcliente" id="txtapellidopatcliente" class="form-control" placeholder="Apellido Paterno" required>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-12 py-1">
                                                <input type="text" name="txtapellidomatcliente" id="txtapellidomatcliente" class="form-control" placeholder="Apeliido Materno" required>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-12 py-1">
                                                <input type="text" name="txtnombrecliente" id="txtnombrecliente" class="form-control" placeholder="Nombre" required>
                                            </div>
                                        </div>
                                        <div class="row py-1">
                                            <div class="col-sm-12 ">
                                                <input type="email" name="txtemailcliente" id="txtemailcliente" class="form-control" placeholder="Correo Electrónico" required>
                                            </div>
                                        </div>
                                        <div class="row py-1">
                                            <div class="col-sm-12" >
                                                <input type="number" name="celcliente" id="celcliente" class="form-control" placeholder="Telefono / Celular" required>
                                            </div>
                                        </div>
                                        <div class="row py-1">
                                            <div class="col-sm-12 ">
                                                <input type="password" name="txtclaveclientereg" id="txtclaveclientereg" class="form-control" placeholder="Contraseña" required>
                                            </div>
                                        </div>
                                        <div class="row py-1">
                                            <div class="col-sm-12 ">

                                                <button type="submit" name="btnregistrarcliente" id="btnregistrarcliente" class="btn btn-primary btn-block">Registrar</button>
                                            </div>
                                        </div>
                                        <div class="row py-1">
                                            <div class="col-sm-12 ">
                                                <a class="btn btn-success btn-block" href="index.jsp">Menu Principal</a>
                                            </div>
                                        </div>
                                        <input type="hidden" name="op" value="2"/>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
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
        <%}else{%>
           <div class="alert alert-danger alert-dismissible fade  fixed-bottom col-lg-3" id="error_alert" role="alert">
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
        <%} else {%>
        <div class="alert alert-success alert-dismissible fade fixed-bottom col-lg-3" id="sucess_alert" role="alert">
            <strong id="sucess_msg"></strong>
            <button type="button" class="close" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <%}%>
        <script type="text/javascript" src="resourse/jquery/jquery.js"></script>
        <script src="resourse/bootstrap/js/bootstrap.js"></script>
        <script src="resourse/js/script.login.user.js" type="text/javascript"></script>
    </body>
</html>
