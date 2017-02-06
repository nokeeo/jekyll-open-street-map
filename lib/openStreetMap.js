function checkMapDimensions(el) {
  if(el.clientHeight == 0 || el.clientWidth == 0) {
    el.style.height = OSMParameters["height"];
    el.style.width = OSMParameters["width"];
  }
}

function plotLatLngs(latLngs) {
    if(latLngs.length > 1) {
      var markerBounds = L.latLngBounds(latLngs);
      map.fitBounds(markerBounds, {
        padding: [5, 5]
      });
    }
    else {
      map.setView(latLngs[0], 16);
    }
}

var mapDiv = document.getElementById(OSMParameters.id);
checkMapDimensions(mapDiv);

var map = L.map(OSMParameters.id);

var locations = OSMParameters.locations;

var latLngs = [];
for(var i = 0; i < locations.length; i++) {
  var curLocation = locations[i];
  var latLng = L.latLng(curLocation.lat, curLocation.lng);
  var marker = L.marker(latLng).addTo(map);
  latLngs.push(latLng);
}

plotLatLngs(latLngs);


L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors'
}).addTo(map);
