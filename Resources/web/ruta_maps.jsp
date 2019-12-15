<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%  String lat1 = String.valueOf(request.getAttribute("lat_en"));
    String lon1 = String.valueOf(request.getAttribute("long_en"));
    String lat2 = String.valueOf(request.getAttribute("lat_pv"));
    String lon2 = String.valueOf(request.getAttribute("long_pv"));
%>
<!DOCTYPE html>
<html style="height:100%">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="resourse/css/maps.css">
        <link rel="shortcut icon" href="resourse/img/favicon.ico">
        <script src="resourse/jquery/jquery.js" type="text/javascript"></script>
        <title>Ruta a Seguir</title>
    </head>
    <body style="height:100%;padding: 0;margin: 0">
        <div class="limiterrute" style="height:100%">
            <input type="hidden" id="lat1" value="<%=lat1 %>"/>
            <input type="hidden" id="lon1" value="<%=lon1 %>"/>
            <input type="hidden" id="lat2" value="<%=lat2 %>"/>
            <input type="hidden" id="lon2" value="<%=lon2 %>"/>
            <div id="map_ruta" class="maprute">  
            </div>
        </div>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDcCBmYTSMPzTaZS7ISySW-iXUSKQyvKQY"></script>
        <script>
            $(document).ready(function () {
             
                initMap($("#lon1").val()*1,$("#lat1").val()*1,$("#lon2").val()*1,$("#lat2").val()*1);
                function initMap(long1, lat1, long2, lat2) {
                    var directionsService = new google.maps.DirectionsService;
                    var directionsDisplay = new google.maps.DirectionsRenderer;
                    var map = new google.maps.Map(document.getElementById('map_ruta'), {
                        center: {lat: -12.046374, lng: -77.0427934},
                        zoom: 13
                    });

                    directionsService.route({
                        origin: {lat: lat2, lng: long2},
                        destination: {lat: lat1, lng: long1},
                        travelMode: 'DRIVING',
                        unitSystem: google.maps.UnitSystem.IMPERIAL
                    }, function (response, status) {
                        if (status === 'OK') {
                            directionsDisplay.setDirections(response);
                        } else {
                            window.alert('Directions request failed due to ' + status);
                        }
                    });
                    directionsDisplay.setMap(map);
                }
            });
        </script>
    </body>
</html>
