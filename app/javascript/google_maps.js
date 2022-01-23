var pin = null;
var lat = 35.64806
var lng = 139.741633

function initMap() {
  // 地図初期化
  var map = new google.maps.Map(document.getElementById('map'), {
      center: { lat: lat, lng: lng },
      scrollwheel: false,
      streetViewControl: false,
      fullscreenControl: false,
      mapTypeControl: false,
      zoom: 14,
      styles: [
              {
                featureType: 'all',
                elementType: 'all',
              },
              {
                featureType: 'poi',
                elementType: 'all',
                stylers: [
                  {visibility: 'off'},
                ],
              }
      ]
  });

  document.getElementById('lat').value = lat;
  document.getElementById('lng').value = lng;

  // 初期マーカー
  pin = new google.maps.Marker({
    map: map, 
    position: new google.maps.LatLng(lat, lng),
  });

  // クリックイベント
  // eはイベントハンドラってやつで、クリックした位置、要素を取得できる。この場合は、クリックした場所の座標？
  map.addListener('click', function(e){
    clickMap(e.latLng, map);
  });

  // 検索ボックス
  const input = document.getElementById("pac-input");
  const searchBox = new google.maps.places.SearchBox(input);

  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
  // Bias the SearchBox results towards current map's viewport.
  map.addListener("bounds_changed", () => {
  searchBox.setBounds(map.getBounds());
  });

  let markers = [];

  // Listen for the event fired when the user selects a prediction and retrieve
  // more details for that place.
  searchBox.addListener("places_changed", () => {
  const places = searchBox.getPlaces();

  if (places.length == 0) {
  return;
  }

  // Clear out the old markers.
  markers.forEach((marker) => {
  marker.setMap(null);
  });
  markers = [];

  // For each place, get the icon, name and location.
  const bounds = new google.maps.LatLngBounds();

  places.forEach((place) => {
  if (!place.geometry || !place.geometry.location) {
    console.log("Returned place contains no geometry");
    return;
  }

  const icon = {
    url: place.icon,
    size: new google.maps.Size(71, 71),
    origin: new google.maps.Point(0, 0),
    anchor: new google.maps.Point(17, 34),
    scaledSize: new google.maps.Size(25, 25),
  };

  // Create a marker for each place.
  markers.push(
    new google.maps.Marker({
      map,
      icon,
      title: place.name,
      position: place.geometry.location,
    })
  );
  if (place.geometry.viewport) {
    // Only geocodes have viewport.
    bounds.union(place.geometry.viewport);
  } else {
    bounds.extend(place.geometry.location);
  }
  });
  map.fitBounds(bounds);
  });
}
window.initMap = initMap;

function clickMap(lat_lng, map){
  lat = lat_lng.lat();
  lng = lat_lng.lng();

  //座標を表示する
  document.getElementById('lat').value = lat;
  document.getElementById('lng').value = lng;

  //中心に移動
  map.panTo(lat_lng);

  // マーカーの更新
  pin.setMap(null);
  pin = null;
  pin = new google.maps.Marker({
    position: lat_lng,
    map: map
  });

}