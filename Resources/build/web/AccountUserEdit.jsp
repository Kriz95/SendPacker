<%@page import="Modelo.Usuarios"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% HttpSession Session = request.getSession();
    if(Session.getAttribute("DatosUser")==null){
        request.getRequestDispatcher("login_user.jsp").forward(request, response);
    }else{
        Usuarios objUser = (Usuarios) Session.getAttribute("DatosUser");

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Editar Datos Cuenta</title>
        <link rel="shortcut icon" href="resourse/img/favicon.ico">
        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="resourse/font-awesome/css/fontawesome-all.css">
        <link rel="stylesheet" href="resourse/bootstrap/css/bootstrap.css" >
        <script src="resourse/jquery/jquery.js"></script>
        <script src="resourse/popper.js/umd/popper.js"></script>
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
    <body>
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
                                <a class="dropdown-item" href="AccountUserSell.jsp">MIS COMPRAS</a>
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
        <div class="container-fluid">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="container-form p-4">
                        <h2 class="text-center" >Editar Datos</h2>
                        <hr>
                        <div>
                            <form id="edit_data" action="ServletCliente" method="POST">
                                <input type="hidden" name="op" value="6">
                                <div class="form-row">
                                    <div class="col-sm-3 py-1">
                                        <label>DNI</label>
                                        <input type="number" class="form-control" name="txtdni" value="<%=objUser.getDNI()%>" readonly>
                                    </div>
                                    <div class="col-sm-9 py-1">
                                        <label for="">Nombres</label>
                                        <input type="text" class="form-control" name="txtnombre" value="<%=objUser.getNombres()%>" required>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="col-sm-6 py-1">
                                        <label for="">Apellido Paterno</label>
                                        <input type="text" class="form-control" name="txtapp" value="<%=objUser.getApelPaterno()%>" required>
                                    </div>
                                    <div class="col-sm-6 py-1">
                                        <label for="">Apellido Materno</label>
                                        <input type="text" class="form-control" name="txtapm" value="<%=objUser.getApelMaterno()%>" required></div>
                                </div>
                                <div class="form-row py-1">    
                                    <div class="col-sm-9 py-1">  
                                        <label for="">Correo electronico</label>
                                        <input type="email" class="form-control" name="txtcorreo" value="<%=objUser.getEmail()%>" required>
                                    </div>
                                    <div class="col-sm-3 py-1">
                                        <label for="">Telefono</label>
                                        <input type="number" class="form-control" name="txtcel" id="txtcel" value="<%=objUser.getCel()%>" required>
                                    </div>
                                </div>
                                <hr>
                                <div class="row justify-content-center">
                                    <div class="col-sm-3 py-1">
                                        <button type="submit" class="btn btn-primary btn-block">Modificar</button>
                                    </div>
                                    <div class="col-sm-3 py-1">
                                        <button type="reset" class="btn btn-danger btn-block">Borrar</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-lg-5">
                    <div class="container-form p-4" style="margin-top: 0em;">
                        <h2 class="text-center">Modificar Contraseña</h2>
                        <hr>
                        <div>
                            <form id="mod_pass" action="ServletCliente" method="POST">
                                <input type="hidden" name="op" value="7"/>
                                <div class="form-row justify-content-center">
                                    <div class="col-sm-5 py-1">
                                        <label>Contraseña Antigua</label>
                                    </div>
                                    <div class="col-sm-auto py-1">
                                        <input type="password" class="form-control" id="oldpass" name="oldpass" required=""/>
                                    </div>
                                </div>
                                <div class="form-row justify-content-center">
                                    <div class="col-sm-5 py-1">
                                        <label>Nueva Contraseña</label>
                                    </div>
                                    <div class="col-sm-auto py-1">
                                        <input type="password" class="form-control" id="newpass" name="newpass" required=""/>
                                    </div>
                                </div>
                                <div class="form-row justify-content-center">
                                    <div class="col-sm-5 py-1">
                                        <label>Confirmar Contraseña</label>
                                    </div>
                                    <div class="col-sm-auto py-1">
                                        <input type="password" class="form-control" id="newpass2" required=""/>
                                    </div>
                                </div>
                                <div class="row justify-content-center">
                                    <div class="col-sm-auto py-1">
                                        <button type="submit" class="btn btn-primary btn-block">Modificar</button>
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
        <script>
            $(document).ready(function () {
                $("#btn_cerrar_U").click(function () {
                    $("#CerrarU").submit();
                });
                $("#mod_pass").submit(function (e) {
                    var pass1 = $("#newpass").val().trim();
                    var pass2 = $("#newpass2").val().trim();
                    if (!(pass1 === pass2)) {
                        $('#error_msg').html("Las Contraseñas deben coincidir");
                        $('#error_alert').addClass('show');
                        e.preventDefault();
                    }
                });
                $('.close').click(function () {
                    $(this).parent().removeClass('show');
                });

                $("#edit_data").submit(function (e) {
                    var txtcel = $("#txtcel").val().length;
                    if (txtcel < 9) {
                        $("#error_msg").html("El Telefono debe tener 9 digitos");
                        $('#error_alert').addClass('show');
                        e.preventDefault();
                    }
                });
            });
        </script>
    </body>
</html><%}%>
