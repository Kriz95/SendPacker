<%@page import="Modelo.Usuarios"%>
<% HttpSession Session = request.getSession();
    boolean flagsessionU = false;
    boolean flagsessionP = false;
    Usuarios objUser = null;
    if (Session.getAttribute("DatosUser") != null) {
        objUser = (Usuarios) Session.getAttribute("DatosUser");
        flagsessionU = true;
    }
    if (Session.getAttribute("usuario") != null) {
        flagsessionP = true;
    }
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <title>SendPacker</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="resourse/img/favicon.ico">
        <link rel="stylesheet" href="resourse/bootstrap/css/bootstrap.css">
        <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="resourse/font-awesome/css/fontawesome-all.css">
        <script src="resourse/popper.js/umd/popper.js"></script>
        <script src="resourse/jquery/jquery.js"></script>
        <script src="resourse/bootstrap/js/bootstrap.js"></script>
        <style>
            h3, h4 {
                margin: 10px 0 30px 0;
                letter-spacing: 10px;
                font-size: 20px;
                color: #111;
                /*titulos*/
            }

            .container {
                padding: 80px 120px;
            }

            .carousel-inner img {
                -webkit-filter: grayscale(90%);
                filter: grayscale(0%); /* make all photos black and white */
                width: 80%; /* Set width to 100% */
                margin: auto;
                /*carrusel*/
            }

            .carousel-caption h3 {
                color: #fff !important;
            }

            @media (max-width: 600px) {
                .carousel-caption {
                    display: none; /* Hide the carousel text when the screen is less than 600 pixels wide */
                }
            }

            .bg-1 {
                background: #2d2d30;
                color: #bdbdbd;
            }

            .bg-1 h3 {
                color: #fff;
            }

            .bg-1 p {
                font-style: italic;
            }

            .btn {
                padding: 10px 20px;
                background-color: #333;
                color: #f1f1f1;
                border-radius: 0;
                transition: .2s;
                /*color botones-nombre*/
            }

            .btn:hover, .btn:focus {
                border: 1px solid #333;
                background-color: #fff;
                color: #000;
            }

            .nav-tabs li a {
                color: #777;
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

            footer {
                background-color: #2d2d30;
                color: #f5f5f5;
                padding: 32px;
            }

            footer a {
                color: #f5f5f5;
            }

            footer a:hover {
                color: #777;
                text-decoration: none;
            }

            .form-control {
                border-radius: 0;
            }

            textarea {
                resize: none;
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
                #myCarousel{
                    margin-top: 100px;
                }
                .alert{
                    margin-right: 0em;
                }

            }
        </style>
    </head>
    <body id="myPage" data-spy="scroll" data-target=".navbar" data-offset="50">
        <nav class="navbar navbar-expand-lg fixed-top navbar-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="#myPage"><img src="resourse/img/Logo.png" style="width: 55px;"></a><!-- Agragas aqui la imagen del logo-->
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#myNavbar"
                        aria-controls="myNavbar" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav">
                        <li><a href="#myPage">INICIO</a></li>
                        <li><a href="#nosotros">NOSOTROS</a></li>
                        <li><a href="#contact">CONTACTANOS</a></li>
                        <li><a href="tienda.jsp">TIENDA</a></li>
                            <%if (flagsessionU) {%>
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
                        <%} else if (flagsessionP) {%>
                        <form action="ValLogin" method="POST" id="CerrarP">
                            <input type="hidden" name="op" value="1"/>
                        </form>
                        <li>
                            <a id="btn_cerrar_P" href="#">CERRAR SESION</a>
                        </li>
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

        <div id="myCarousel" class="carousel slide" data-ride="carousel">
            <!-- Indicators -->
            <ol class="carousel-indicators">
                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#myCarousel" data-slide-to="1"></li>
                <li data-target="#myCarousel" data-slide-to="2"></li>
            </ol>

            <!-- Wrapper for slides -->
            <div class="carousel-inner" role="listbox">
                <div class="carousel-item active">
                    <img src="resourse/img/portal/envio.jpg" class="img-fluid" style="width: 1200px; height: auto;">
                    <div class="carousel-caption d-none d-md-block">
                        <h3>Servicio a domicilo</h3>
                        <p>Rapido,efectivo y con las rutas mas economicas a cualquier destido.</p>
                    </div>
                </div>

                <div class="carousel-item">
                    <img src="resourse/img/portal/producto.jpg" class="img-fluid" style="width: 1200px; height: auto">
                    <div class="carousel-caption d-none d-md-block">
                        <h3>Mercado</h3>
                        <p>Catalogo amplio con distintos productos garantizados y economicos.</p>
                    </div>
                </div>

                <div class="carousel-item">
                    <img src="resourse/img/portal/compra.jpg" class="img-fluid" style="width: 1200px; height: auto">
                    <div class="carousel-caption d-none d-md-block">
                        <h3>Compra Online</h3>
                        <p>Compras al instante, sin la necesidad de salir de su casa, ademas de proporcionar un servicio de
                            envio a domicilio economico a su ubiación.</p>
                    </div>
                </div>
            </div>

            <!-- Left and right controls -->
            <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>

        <!-- Container (The Band Section) -->
        <div id="nosotros" class="container-fluid text-center my-5">
            <h3>NOSOTROS</h3>
            <p><em>¡La oportunidad de crecer es ahora!</em></p>
            <p>Somos un grupo de empresas peruanas que nos especializamos en la venta y envio de paquetes de manera eficiente,
                contamos con 10 años de experiencia en el mercado de bienes y servicios tranportando a cualquier destino a nivel
                nacional y muy pronto de manera internacional.</p>
            <br>
            <img src="resourse/img/portal/entrega-de-productos.jpg" class="img-fluid" style="width: 750px; height: auto;">
        </div>
        <!-- Container (Contact Section) -->
        <div id="contact" class="my-5 container-fluid">
            <form method="POST" action="ServletCliente">
                <h3 class="text-center">CONTACTANOS</h3>
                <p class="text-center"><em>Por que la calidad entregada al usuario es lo que importa, creamos este portal para el
                        usuario.</em></p>
                <div class="row justify-content-center">
                    <div class="col-md-2">
                        <p>Datos de contacto:</p>
                        <p><span class="glyphicon glyphicon-map-marker"></span>Lima, PE</p>
                        <p><span class="glyphicon glyphicon-phone"></span>Phone: +01 84725716</p>
                        <p><span class="glyphicon glyphicon-envelope"></span>Email: send_packer@gmail..com</p>
                    </div>

                    <input type="hidden" name="op" value="10"/>
                    <div class="col-md-6">
                        <div class="row">
                            <div class="col-sm-6 form-group">
                                <input class="form-control" id="name" name="name" placeholder="Nombre" type="text" required>
                            </div>
                            <div class="col-sm-6 form-group">
                                <input class="form-control" id="email" name="email" placeholder="Email" type="email" required>
                            </div>
                        </div>
                        <textarea class="form-control" id="comments" name="comments" placeholder="Comentario" rows="5"></textarea>
                        <br>
                        <div class="row">
                            <div class="col-md-12 form-group">
                                <button class="btn pull-right" type="submit">Enviar</button>
                            </div>
                        </div>
                    </div>

                </div>
                <br>
            </form>
        </div>

        <!-- Footer -->
        <footer class="text-center">
            <a class="up-arrow" href="#myPage" data-toggle="tooltip" title="TO TOP">
                <span class="glyphicon glyphicon-chevron-up"></span>
            </a><br><br>
            <p>Copyright <a href="#myPage" data-toggle="tooltip" title="Creado por Grupo 01">SendPacker</a> - Todos los derechos
                reservados.</p>
        </footer>
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
        <script>
            $(document).ready(function () {
                // Initialize Tooltip
                $('[data-toggle="tooltip"]').tooltip();

                // Add smooth scrolling to all links in navbar + footer link
                $(".navbar a, footer a[href='#myPage']").on('click', function (event) {

                    // Make sure this.hash has a value before overriding default behavior
                    if (this.hash !== "") {

                        // Prevent default anchor click behavior
                        event.preventDefault();

                        // Store hash
                        var hash = this.hash;

                        // Using jQuery's animate() method to add smooth page scroll
                        // The optional number (900) specifies the number of milliseconds it takes to scroll to the specified area
                        $('html, body').animate({
                            scrollTop: $(hash).offset().top
                        }, 900, function () {

                            // Add hash (#) to URL when done scrolling (default click behavior)
                            window.location.hash = hash;
                        });
                    } // End if
                });

                $("#btn_cerrar_U").click(function () {
                    $("#CerrarU").submit();
                });

                $("#btn_cerrar_P").click(function () {
                    $("#CerrarP").submit();
                });
                
                $('.close').click(function () {
                    $(this).parent().removeClass('show');
                });
            });
        </script>

    </body>
</html>
