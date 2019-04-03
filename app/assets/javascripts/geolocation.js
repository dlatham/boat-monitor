$( document ).ready(function() {
    console.log( "Requesting geolocation..." );
    if (navigator.geolocation){
        navigator.geolocation.getCurrentPosition(showPosition);
        console.log( "Requesting geolocation..." );
    } else {
    	console.log( "Geolocation not supported by this browser." );
    }

});

function showPosition(position){
	console.log("Latitude: " + position.coords.latitude);
	console.log("Longitude: " + position.coords.longitude);
	if ($('.location-content').length == 1) {
		console.log("Writing to location-content div...");
		$('.location-content').text("Latitude: " + position.coords.latitude + ", Longitude: " + position.coords.longitude);
		$('#location-spinner').hide();
	} else {
		console.log("No location-content div found.");
	}
}