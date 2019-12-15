$(document).ready(function () {
//Llamar Articulos
    $(document).on('click', "button[name='mod']", function () {
        var cod = this.id.substring(4);
        $.ajax({
            type: 'POST',
            url: 'ValLogin',
            data: {op: 12, cod: cod},
            dataType: 'json',
            success: function (data) {
                $("#cod").val(data.cod);
                $("#nom").val(data.nom);
                $("#precio").val(data.precio);
                $("#cant").val(data.cant);
                $("#cate").val(data.cate);
                $("#desc_mod").val(data.descrip);
                $("#est_mod").val(data.estado);
                $("#mod_thumbnail").html("<img class='img-fluid img-thumbnail' src='" + data.ruta + "' style='height: 220px; width:220px'>");
                $("#nomfile_mod").html("Subir Imagen");
                $("#carga_mod").val("");
                $("#op").val("2");
                $("#op").attr("form", "form_modificar");
            },
            error: function () {
                alert('error peticion ajax');
            }
        });
    });
    //Eliminar Articulo
    $(document).on('click', "button[name='btn_eli_arti']", function () {
        var coda = this.id.substring(4);
        $("#codarti").val(coda);
        $("#op").val("15");
        $("#op").attr("form", "form_desha_arti");
    });
//Llamar Modal Ingresar
    $("#ingre").click(function () {
        $("#id_modal").click();
        $("#op").val("1");
        $("#op").attr("form", "form_ingre");
    });
    //Estadisticas
    $(document).on('click', "a[name='form_año']", function () {
        var año = this.id.substring(2);
        $("#" + año).submit();
    });
    $("#esta_todo").click(function () {
        $("#form_todo").submit();
    });
    function initMap(long, lati) {
        var posicion = {lat: lati, lng: long};
        map = new google.maps.Map(document.getElementById('map_e'), {
            center: {lat: -12.046374, lng: -77.0427934},
            zoom: 13
        });
        marker = new google.maps.Marker({
            position: posicion,
            map: map
        });
    }


//Rellenar Modal Tomar Envios
    $(document).on('click', "button[name='tomar_e']", function () {
        var datos = this.id.split("_");
        var arti = datos[2];
        var venta = datos[1];
        $.ajax({
            type: 'POST',
            url: 'ValLogin',
            data: {
                op: 3,
                venta: venta,
                arti: arti
            },
            dataType: 'json',
            success: function (data) {
                $("#codarti_en").val(arti);
                $("#codvent").val(venta);
                $("#arti_en").val(data.arti);
                $("#cant_en").val(data.cant);
                $("#dni_en").val(data.dni);
                $("#nom_en").val(data.nom);
                $("#ruc_en").val(data.ruc);
                $("#fecha_en").val(data.fecha);
                $("#razon_en").val(data.razon);
                $("#lat_en").val(data.lat_e);
                $("#long_en").val(data.long_e);
                $("#lat_pv").val(data.lat_p);
                $("#long_pv").val(data.long_p);
                $("#op").val("18");
                $("#op").attr("form", "form_tomar");
                initMap(data.long_e, data.lat_e);
            },
            error: function () {
                alert('error peticion ajax');
            }
        });
    });
    //Completar Envio
    $(document).on('click', "button[name='comple_e']", function () {
        var datos = this.id.split("_");
        arti = datos[2];
        venta = datos[1];
        $("#id_v").val(venta);
        $("#id_art").val(arti);
        $("#op").val("19");
        $("#op").attr("form", "form_complete");
    });
    //Ver Mapa de Ruta
    $(document).on('click', "button[name='btn_ruta']", function () {
        var datos = this.id.split("_");
        var arti = datos[1];
        var venta = datos[0];
        $("#op").val("17");
        $("#op").attr("form", venta + arti);
        $("#" + venta + arti).submit();
    });
    $('.close').click(function () {
        $(this).parent().removeClass('show');
    });
    $("#carga").change(function () {
        if ($("#carga").val() !== "") {
            $("#nomfile").html($("#carga").val().substring($("#carga").val().lastIndexOf("\\")));
            filePreview(this);
        }
    });
    $("#carga_mod").change(function () {
        if ($("#carga_mod").val() !== "") {
            $("#nomfile_mod").html($("#carga_mod").val().substring($("#carga_mod").val().lastIndexOf("\\")));
            filePreviewMod(this);
        }
    });
    $("#form_ingre").submit(function (e) {
        var namefile = $("#carga").val();
        var ext = namefile.substring(namefile.lastIndexOf("\."));
        if (ext !== ".jpg" && ext !== ".png") {
            $("#error_msg").html("Solo se puede subir archivos con extencion JPG y PNG");
            $('#error_alert').addClass('show');
            e.preventDefault();
        }
    });
    $("#form_modificar").submit(function (e) {
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
    $("#report_execute").click(function (e) {
        $("#report").submit();
    });
    function filePreview(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#thumbnail').html("");
                $('#thumbnail').html('<img src="' + e.target.result + '" class="img-fluid img-thumbnail" style="width:220px; height:220px"/>');
            };
            reader.readAsDataURL(input.files[0]);
        }
    }

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

    $("#close_modal").click(function (e) {
        $('#thumbnail').html("");
        $('#thumbnail').html('<img src="resourse/img/no-imagen.jpg" class="img-fluid img-thumbnail" style="width:220px; height:220px"/>');
        $('#nomfile').html("Subir Imagen");
        $('#carga').val("");
        $('#nom_ingre').val("");
        $('#precio_ingre').val("");
        $('#cant_ingre').val("");
        $('#desc_ingre').val("");
    });
    $("#callmap").click(function () {
        initMap1();
    });
    $("#callmap2").click(function () {
        initMap2();
    });
    function initMap(long, lati) {

        var posicion = {lat: lati, lng: long};
        map = new google.maps.Map(document.getElementById('map_entrega'), {
            center: {lat: -12.046374, lng: -77.0427934},
            zoom: 13
        });
        marker = new google.maps.Marker({
            position: posicion,
            map: map
        });
    }



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

    $("#mod_pass").submit(function (e) {
        var pass1 = $("#newpass").val().trim();
        var pass2 = $("#newpass2").val().trim();
        if (!(pass1 === pass2)) {
            $('#error_msg').html("Las Contraseñas deben coincidir");
            $('#error_alert').addClass('show');
            e.preventDefault();
        }
    });
    $("#callChart").click(function () {
        $.ajax({
            type: 'POST',
            url: 'ServletEstadistica',
            data: {
                op: 4
            },
            dataType: 'json',
            success: function (data) {
                chart(data.dataChart);
            },
            error: function () {
                alert('error peticion ajax');
            }
        });
    });
    function  chart(data) {
        //Generar Lineas por cada Articulo y Mes
        var datashet = [];
        for (var i = 0; i < data.length; i++) {
            var j = 0;
            var dat = [];
            while (j < data[0].length) {
                dat.push(data[i][j + 3]);
                j = j + 4;
            }
            var colores = color();
            var datas = {label: data[i][0],
                backgroundColor: colores,
                borderColor: colores,
                data: dat,
                fill: false};
            datashet.push(datas);
        }
        //Generar Las Etiquetas de los puntos
        var Labels = [];
        var k = 1;
        while (k < data[0].length) {
            Labels.push(data[0][k] + " \ " + parseInt(data[0][k + 1]));
            k = k + 4;
        }

        var config = {
            // The type of chart we want to create
            type: 'line',
            // The data for our data
            data: {
                labels: Labels,
                datasets: datashet
            },
            // Configuration options go here
            options: {
                maintainAspectRatio: false,
                title: {
                    display: true,
                    text: 'Pronostico'
                },
                scales: {
                    xAxes: [{
                            display: true,
                            scaleLabel: {
                                display: true,
                                labelString: 'Meses'
                            }
                        }],
                    yAxes: [{
                            display: true,
                            scaleLabel: {
                                display: true,
                                labelString: 'Ventas(S/)'
                            }
                        }]
                },
                tooltips: {
                    mode: 'nearest',
                    intersect: false
                }
            }
        };
        var ctx = document.getElementById('myChart').getContext('2d');
        var myChart = new Chart(ctx, config);
    }

    function color()
    {
        var r = Math.round(Math.random() * 255);
        var g = Math.round(Math.random() * 255);
        var b = Math.round(Math.random() * 255);
        var a = 1; //transparencia entre 0 a 1
        return this.rgba = "rgba(" + r + ", " + g + ", " + b + ", " + a + ")";
    }

    $("#report_v").click(function () {
        var time = $("#filter_sell").val();
        $.ajax({
            type: 'POST',
            url: 'ValLogin',
            data: {
                op: 33,
                time: time
            },
            dataType: 'json',
            success: function (data) {
                $('#oilChart').remove(); // this is my <canvas> element
                $('#graph-container').append('<canvas id="oilChart"><canvas>');
                chartDough(data.data);
            },
            error: function () {
                alert('error peticion ajax');
            }
        });
    });

    function  chartDough(data) {
        var oilCanvas = document.getElementById("oilChart");
        var labels = [];
        var datas = [];
        var colores = [];

        for (var i = 0; i < data.length; i++) {
            if (i % 2 === 0) {
                labels.push(data[i]);
            } else {
                datas.push(data[i]);
                colores.push(color());
            }
        }

        var oilData = {
            labels: labels,
            datasets: [
                {
                    data: datas,
                    backgroundColor: colores
                }]
        };

        var pieChart = new Chart(oilCanvas, {
            type: 'doughnut',
            data: oilData
        });
    }

});
