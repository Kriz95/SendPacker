var map;
var marker;
var cont = 0;
var boton;

function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: -12.046374, lng: -77.0427934},
        zoom: 13
    });

    map.addListener('click', function (event) {
        addMarker(event.latLng);
    });

    boton = document.getElementById("modal_conf");

}

function addMarker(myLatLng) {
    if (cont > 0) {
        marker.setMap(null);
    }
    marker = new google.maps.Marker({
        position: myLatLng,
        draggable: true,
    });
    marker.setMap(map);
    cont = cont + 1;
    boton.disabled = false;
}

function setLongLat() {
    document.getElementById("prov_Long").value = marker.getPosition().lng();
    document.getElementById("prov_Lat").value = marker.getPosition().lat();
}

function informar() {
    alert(marker.getPosition());
}

$(document).ready(function () {
    $("#horarios").hide();
    $('#tprov').change(function () {
        var tprov = $('#tprov').val() * 1;
        if (tprov === 2) {
            $("#horarios").show();
            $("#prov_hfin").addClass("input100");
            $("#prov_hini").addClass("input100");
            $("#1").addClass("validate-input");
            $("#2").addClass("validate-input");
        } else {
            $("#horarios").hide();
            $("#prov_hfin").removeClass("input100");
            $("#prov_hini").removeClass("input100");
            $("#1").removeClass("validate-input");
            $("#2").removeClass("validate-input");
        }
    });



    $('#form_reg').on('submit', function (e) {
        var input = $('.validate-input .input100');
        for (var i = 0; i < input.length; i++) {
            if (validate(input[i]) === false) {
                showValidate(input[i]);
                e.preventDefault();
            }
        }

        if ($("#password").val() !== $("#password_confirmation").val()) {
            for (var i = 0; i < input.length; i++) {
                if ($(input[i]).attr('type') === 'password') {
                    showValidate(input[i]);
                }
            }
            e.preventDefault();
        }
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

    $('.close').click(function () {
        $(this).parent().removeClass('show');
    });
});


