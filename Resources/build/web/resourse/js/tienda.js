/* global google, posicion, map */

$(document).ready(function () {
    //Cerrar Sesion
    $("#btn_cerrar_U").click(function () {
        $("#CerrarU").submit();
    });

    //Identificar Articulo
    var codarti = null;
    $(document).on('click', "button[name='btn_arti']", function () {
        codarti = this.id;
    });
    $("#btn_agregar").click(function () {
        $.ajax({
            type: 'POST',
            url: 'ServletCliente',
            data: {op: 4, codarti: codarti},

            success: function (data) {
                codarti = null;
                alert("Agregado Correctamente");
            },
            error: function () {
                alert('error peticion ajax');
            }
        });
    });
    Mapa();
    function Mapa() {
        var map;
        var marker;
        var cont = 0;


        map = new google.maps.Map(document.getElementById('map'), {
            center: {lat: -12.046374, lng: -77.0427934},
            zoom: 13
        });

        map.addListener('click', function (event) {
            addMarker(event.latLng);
        });

        function addMarker(myLatLng) {
            if (cont > 0) {
                marker.setMap(null);
            }
            marker = new google.maps.Marker({
                position: myLatLng,
                draggable: true
            });
            marker.setMap(map);
            cont = cont + 1;
            $("#btn_comprar").attr("disabled", false);
            $("#long").val(marker.getPosition().lng());
            $("#lat").val(marker.getPosition().lat());
        }
    }
    ;

    $(document).on('click', "button[name='btn_del']", function () {
        var codarti = this.id.substring(8);
        $("#codarti").attr("value", codarti);
    });

    $(document).on('click', "button[name='btn_edit']", function () {
        var codarti = this.id.substring(9);
        $("#codart_cant").attr("value", codarti);
    });

    $("#del_arti").submit(function (e) {
        $("#op").attr("form", "del_arti");
        $("#op").attr("value", "8");
    });

    $("#mod_cant").submit(function (e) {
        if (($("#cantarti").val() * 1) < 1) {
            $('#error_msg').html("La Cantidad debe ser mayor a 0");
            $('#error_alert').addClass('show');
            e.preventDefault();
        } else {
            $("#op").attr("form", "mod_cant");
            $("#op").attr("value", "9");
        }
    });

    $('.close').click(function () {
        $(this).parent().removeClass('show');
    });



});