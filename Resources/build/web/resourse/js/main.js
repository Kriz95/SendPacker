(function ($) {
    "use strict";
    /*==================================================================
     [ Validate ]*/
    var input = $('.validate-input .input100');

    $('.validate-form').on('submit', function () {
        var check = true;

        for (var i = 0; i < input.length; i++) {
            if (validate(input[i]) == false) {
                showValidate(input[i]);
                check = false;
            }
        }


        return check;
    });


    $('.validate-form .input100').each(function () {
        $(this).focus(function () {
            hideValidate(this);
        });
    });


    function validate(input) {

        if ($(input).attr('type') === 'email' || $(input).attr('name') === 'email') {
            if ($(input).val().trim().match(/^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{1,5}|[0-9]{1,3})(\]?)$/) == null) {
                return false;
            }
        } else {
            if ($(input).attr('type') == 'text' && $(input).attr('name') == 'prov_ruc') {
                if ($(input).val().trim().match(/^([0-9])*$/) == null || $(input).val().trim() == '' || $(input).val().trim().length != 11) {
                    return false;
                }
            } else {
                if ($(input).val().trim() == '') {
                    return false;
                }
            }
        }


    }


    function showValidate(input) {
        var thisAlert = $(input).parent();

        $(thisAlert).addClass('alert-validate');
    }

    function hideValidate(input) {
        var thisAlert = $(input).parent();

        $(thisAlert).removeClass('alert-validate');
    }


})(jQuery);
$(document).ready(function () {
//Llamar Modificar Prov Ventas
    $(document).on('click', "button[name='mod_v']", function () {
        var ruc = this.id.substring(0, 11);

        $.ajax({
            type: 'POST',
            url: 'ValLogin',
            data: {op: 4, ruc: ruc},
            dataType: 'json',
            success: function (data) {
                $("#ruc_v").val(data.ruc);
                $("#razon_v").val(data.razon);
                $("#direc_v").val(data.direccion);
                $("#email_v").val(data.email);
                $("#cont_v").val(data.cont);
                $("#ncont_v").val(data.ncont);
                $("#select_v").val(data.est);
                $("#long_v").val(data.lon);
                $("#lat_v").val(data.lat);
                initMap1();
                $("#op").attr("form", "form_modificar_v");
                $("#op").val("6");
            },
            error: function () {
                alert('error peticion ajax');
            }
        });
    });
//Eliminar Prov Ventas
    $(document).on('click', "button[name='eli_v']", function () {
        var ruc = this.id.substring(0, 11);
        $("#iruc").val(ruc);
        $("#iruc").attr("form", "eli_ventas");
        $("#op").val("5");
        $("#op").attr("form", "eli_ventas");
    });

    //Llamar Modificar Prov Envios
    $(document).on('click', "button[name='mod_e']", function () {
        var ruc = this.id.substring(0, 11);

        $.ajax({
            type: 'POST',
            url: 'ValLogin',
            data: {op: 7, ruc: ruc},
            dataType: 'json',
            success: function (data) {
                $("#ruc_e").val(data.ruc);
                $("#razon_e").val(data.razon);
                $("#direc_e").val(data.direccion);
                $("#email_e").val(data.email);
                $("#cont_e").val(data.cont);
                $("#ncont_e").val(data.ncont);
                $("#select_e").val(data.est);
                $("#long_e").val(data.lon);
                $("#lat_e").val(data.lat);
                $("#hini_e").val(data.hini);
                $("#hfin_e").val(data.hfin);
                initMap2();
                $("#op").val("8");
                $("#op").attr("form", "form_modificar_e");
            },
            error: function () {
                alert('error peticion ajax');
            }
        });
    });

//Eliminar Prov Ventas
    $(document).on('click', "button[name='eli_e']", function () {
        var ruc = this.id.substring(0, 11);
        $("#iruc").val(ruc);
        $("#iruc").attr("form", "form_eli_PE");
        $("#op").val("5");
        $("#op").attr("form", "form_eli_PE");
    });

//Llamar Modificar Usuarios
    $(document).on('click', "button[name='mod_u']", function () {
        var dni = this.id.substring(0, 8);

        $.ajax({
            type: 'POST',
            url: 'ValLogin',
            data: {op: 9, dni: dni},
            dataType: 'json',
            success: function (data) {
                $("#dni_u").val(data.dni);
                $("#nom_u").val(data.nom);
                $("#app_u").val(data.app);
                $("#apm_u").val(data.apm);
                $("#email_u").val(data.email);
                $("#select_u").val(data.est);
                $("#cel_u").val(data.cel);
                $("#op").val("10");
                $("#op").attr("form", "form_mod_u");
            },
            error: function () {
                alert('error peticion ajax');
            }
        });
    });

//Eliminar Usuario
    $(document).on('click', "button[name='eli_u']", function () {
        var dni = this.id.substring(0, 8);
        $("#idni_u").val(dni);
        $("#op").val("11");
        $("#op").attr("form", "form_eli_u");
    });

    //Eliminar Venta
    $(document).on('click', "button[name='eli_venta']", function () {
        var cod = this.id.substring(14);
        $("#codv").val(cod);
        $("#op").val("20");
        $("#op").attr("form", "eli_venta");
    });

    //Eliminar Articulo
    $(document).on('click', "button[name='eli_arti']", function () {
        var coda = this.id.substring(13);
        $("#codarti").val(coda);
        $("#op").val("24");
        $("#op").attr("form", "form_eli_arti");
    });

//Llamar Modificar Ventas
    $(document).on('click', "button[name='mod_venta']", function () {
        var cod = this.id.substring(14);
        $.ajax({
            type: 'POST',
            url: 'ValLogin',
            data: {op: 21, codv: cod},
            dataType: 'json',
            success: function (data) {
                $("#cod_v").val(data.cod_v);
                $("#fecha_v").val(data.fecha);
                $("#dni_v").val(data.dni);
                $("#lati_venta").val(data.latv);
                $("#long_venta").val(data.longv);
                $("#total_v").val(data.totalv);
                $("#estado_v").val(data.estadov);
                initMap3();
                $("#op").val("22");
                $("#op").attr("form", "form_mod_venta");
            },
            error: function () {
                alert('error peticion ajax');
            }
        });
    });

    //Llamar Detalle Ventas
    $(document).on('click', "button[name='deta_venta']", function () {
        var codv = this.id.substring(15);
        $.ajax({
            type: 'POST',
            url: 'ValLogin',
            data: {op: 23, codv: codv},
            Type: 'get',
            success: function (data) {
                $("#modal-body-deta").html(data);
            },
            error: function () {
                alert('error peticion ajax');
            }
        });
    });

    //Llamar Modificar Articulos
    $(document).on('click', "button[name='mod_arti']", function () {
        var codart = this.id.substring(13);
        $.ajax({
            type: 'POST',
            url: 'ValLogin',
            data: {op: 12, cod: codart},
            dataType: 'json',
            success: function (data) {
                $("#cod_arti").val(data.cod);
                $("#nom_arti").val(data.nom);
                $("#prec_arti").val(data.precio);
                $("#cant_arti").val(data.cant);
                $("#cate_arti").val(data.cate);
                $("#desc_arti").val(data.descrip);
                $("#est_arti").val(data.estado);
                $("#mod_thumbnail").html("<img class='img-fluid img-thumbnail' src='"+data.ruta+"' style='height: 220px; width:220px'>");
                $("#nomfile_mod").html("Subir Imagen");
                $("#carga_mod").val("");
                $("#op").val("2");
                $("#op").attr("form", "form_mod_arti");
            },
            error: function () {
                alert('error peticion ajax');
            }
        });
    });


//Mapas

    var marker;

    function initMap1() {
        var long = document.getElementById("long_v").value * 1;
        var lati = document.getElementById("lat_v").value * 1;
        var posicion = {lat: lati, lng: long};
        map1 = new google.maps.Map(document.getElementById('map_v'), {
            center: {lat: -12.046374, lng: -77.0427934},
            zoom: 13
        });

        marker = new google.maps.Marker({
            position: posicion,
            map: map1
        });

        map1.addListener('click', function (event) {
            addMarker1(event.latLng);
        });
    }

    function addMarker1(myLatLng) {
        marker.setMap(null);
        marker = new google.maps.Marker({
            position: myLatLng,
            draggable: true,
        });
        marker.setMap(map1);
        document.getElementById("long_v").value = marker.getPosition().lng();
        document.getElementById("lat_v").value = marker.getPosition().lat();
    }

    function initMap2() {
        var long = document.getElementById("long_e").value * 1;
        var lati = document.getElementById("lat_e").value * 1;
        var posicion = {lat: lati, lng: long};
        map2 = new google.maps.Map(document.getElementById('map_e'), {
            center: {lat: -12.046374, lng: -77.0427934},
            zoom: 13
        });

        marker = new google.maps.Marker({
            position: posicion,
            map: map2
        });

        map2.addListener('click', function (event) {
            addMarker2(event.latLng);
        });
    }

    function addMarker2(myLatLng) {
        marker.setMap(null);
        marker = new google.maps.Marker({
            position: myLatLng,
            draggable: true,
        });
        marker.setMap(map2);
        document.getElementById("long_e").value = marker.getPosition().lng();
        document.getElementById("lat_e").value = marker.getPosition().lat();
    }

    function initMap3() {
        var long = document.getElementById("long_venta").value * 1;
        var lati = document.getElementById("lati_venta").value * 1;
        var posicion = {lat: lati, lng: long};
        map_ventas = new google.maps.Map(document.getElementById('map_ventas'), {
            center: {lat: -12.046374, lng: -77.0427934},
            zoom: 13
        });

        marker = new google.maps.Marker({
            position: posicion,
            map: map_ventas
        });

        map_ventas.addListener('click', function (event) {
            addMarker3(event.latLng);
        });
    }

    function addMarker3(myLatLng) {
        marker.setMap(null);
        marker = new google.maps.Marker({
            position: myLatLng,
            draggable: true,
        });
        marker.setMap(map_ventas);
        document.getElementById("long_venta").value = marker.getPosition().lng();
        document.getElementById("lati_venta").value = marker.getPosition().lat();
    }
    
    
    $('.close').click(function () {
        $(this).parent().removeClass('show');
    });
    
    $("#form_mod_arti").submit(function (e) {
        var namefile = $("#carga_mod").val();
        var ext = namefile.substring(namefile.lastIndexOf("\."));
        if (namefile !== "") {
            if (ext !== ".jpg" && ext !== ".png") {
                $("#error_msg").html("Solo se puede subir archivos con extencion JPG y PNG");
                $('#error_alert').addClass('show');
                e.preventDefault();
            }
        }
    });
    
    $("#carga_mod").change(function () {
        if ($("#carga_mod").val() !== "") {
            $("#nomfile_mod").html($("#carga_mod").val().substring($("#carga_mod").val().lastIndexOf("\\")));
            filePreviewMod(this);
        }
    });
    
    function filePreviewMod(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#mod_thumbnail').html("");
                $('#mod_thumbnail').html('<img src="' + e.target.result + '" class="img-fluid img-thumbnail" style="width:220px; height:220px"/>');
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
});





