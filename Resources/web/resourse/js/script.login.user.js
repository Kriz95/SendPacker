$(document).ready(function () {
    $(function () {
        $('#login-form-link').click(function (e) {
            $("#login-form").delay(100).fadeIn(100);
            $("#register-form").fadeOut(100);
            $('#register-form-link').removeClass('active');
            $(this).addClass('active');
            e.preventDefault();
        });
        $('#register-form-link').click(function (e) {
            $("#register-form").delay(100).fadeIn(100);
            $("#login-form").fadeOut(100);
            $('#login-form-link').removeClass('active');
            $(this).addClass('active');
            e.preventDefault();
        });
    });

    $('.close').click(function () {
        $(this).parent().removeClass('show');
    });

    $("#register-form").submit(function (e) {
        var dni = $("#txtdniclientereg").val().length;
        if (dni !==8) {
            $("#error_msg").html("El DNI debe ser de 8 digitos");
            $('#error_alert').addClass('show');
            e.preventDefault();
        } else {
            if ($("#celcliente").val().length < 9 || $("#celcliente").val().length > 9 ) {
                $("#error_msg").html("El Telefono debe ser de 9 digitos");
                $('#error_alert').addClass('show');
                e.preventDefault();
            } else {
                if ($("#txtclaveclientereg").val().length < 4) {
                    $("#error_msg").html("La contraseña debe ser der 4 caracteres a más");
                    $('#error_alert').addClass('show');
                    e.preventDefault();
                }
            }
        }

    });


});



