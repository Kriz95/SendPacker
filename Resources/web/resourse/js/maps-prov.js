function initMap() {
    var directionsService = new google.maps.DirectionsService;
    var directionsDisplay = new google.maps.DirectionsRenderer;
    var map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: -12.046374, lng: -77.0427934},
        zoom: 13
        });
   
    directionsService.route({
          origin: {lat: -11.953026635363011, lng: -77.07011103630066},
          destination: {lat: -12.054767929851149, lng: -77.0420209238037}, 
          travelMode: 'DRIVING',
          unitSystem: google.maps.UnitSystem.IMPERIAL
        }, function(response, status) {
          if (status === 'OK') {
            directionsDisplay.setDirections(response);
          } else {
            window.alert('Directions request failed due to ' + status);
          }
        });
     directionsDisplay.setMap(map);

   
}




