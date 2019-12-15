$(document).ready(function () {

    $(document).on('click', "button[name='btn_detalles']", function () {
        var codart = this.id.substring(4);
        $.ajax({
            type: 'POST',
            url: 'ServletMarket',
            data: {
                op: 1,
                codarti: codart
            },
            dataType: 'json',
            success: function (data) {
                $("#img_detaarti").html(data.img);
                $("#title").html(data.title);
                $("#cod").html(data.cod);
                $("#desc").html(data.desc);
                $("#prec").html(data.prec);
                $("#total").val($("#artiprec").val());
            },
            error: function () {
                alert('error peticion ajax');
            }
        });

    });
    $("#articant").change(function () {
        var cant = $("#articant").val() * 1;
        var prec = $("#artiprec").val() * 1;
        $("#total").val(cant * prec);

    });

    $("#btn_cerrar_U").click(function () {
        $("#CerrarU").submit();
    });

    $("#InsCarrito").submit(function (e) {
        var cant = $("#articant").val();
        if (cant<=0) {
            $('#error_msg').html("La Cantidad debe ser mayor a 0");
            $('#error_alert').addClass('show');
            e.preventDefault();
        }
    });

    $('.close').click(function () {
        $(this).parent().removeClass('show');
    });
});
