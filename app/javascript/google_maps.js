var pin = null;
var lat = gon.latitude;
var lng = gon.longitude;
var jiroMarker = [];
var saunaMarker = [];

function initMap() {
  // 地図初期化
  var map = new google.maps.Map(document.getElementById('map'), {
      center: { lat: lat, lng: lng },
      scrollwheel: false,
      streetViewControl: false,
      fullscreenControl: false,
      mapTypeControl: false,
      gestureHandling: 'greedy',
      zoom: 13,
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

  // 初期ピン
  pin = new google.maps.Marker({
    map: map, 
    position: new google.maps.LatLng(lat, lng),
    animation: google.maps.Animation.BOUNCE
  });

  circle = new google.maps.Circle({
    center: new google.maps.LatLng(lat, lng),
    map: map,
    radius: 1500,
    clickable: false,
    fillColor: '#297EDD',
    fillOpacity: 0.1,
    strokeColor: '#297EDD',
    strokeOpacity: 0.6,
    strokeWeight: 0.7,
  });

  if (gon.jiros) {

    for (let i = 0; i < gon.jiros.length; i++) {

      // 検索結果のジローの座標取得
      markerLatLng = new google.maps.LatLng({
        lat: parseFloat(gon.jiros[i]['latitude']),
        lng: parseFloat(gon.jiros[i]['longitude'])
      });

      // マーカーの作成
      jiroMarker[i] = new google.maps.Marker({
        position: markerLatLng,
        map: map,
        icon: { 
          url: `/assets/jiro_${i}.png`,
          scaledSize: new google.maps.Size(30, 46)
        },
        animation: google.maps.Animation.DROP
      });
      jiroMarker[i].addListener('click', () => {
        location.hash = `#jiro-${gon.jiros[i]['id']}`;
      });
    }
  }

  if (gon.saunas) {

    for (let i = 0; i < gon.saunas.length; i++) {

      // 検索結果のサウナの座標取得
      markerLatLng = new google.maps.LatLng({
        lat: parseFloat(gon.saunas[i]['latitude']),
        lng: parseFloat(gon.saunas[i]['longitude'])
      });

      // マーカーの作成
      saunaMarker[i] = new google.maps.Marker({
        position: markerLatLng,
        map: map,
        icon: { 
          url: `/assets/sauna_${i}.png`,
          scaledSize: new google.maps.Size(30, 46)
        },
        animation: google.maps.Animation.DROP
      });
      saunaMarker[i].addListener('click', () => {
        location.hash = `#sauna-${gon.saunas[i]['id']}`;
      });
    }
  }

  // ピンの移動
  map.addListener('click', function(e){
    clickMap(e.latLng, map);
  });

  // 現在地へ移動ボタン
  const currentLocation = document.createElement('button');
  currentLocation.textContent = '現在地へ移動する';
  currentLocation.classList.add('block', 'mt-3', 'mr-5', 'text-white', 'text-white', 'bg-main-blue', 'rounded-full', 'hover:bg-dark-blue', 'font-semibold', 'text-sm', 'px-5', 'py-2.5', 'text-center', 'drop-shadow-lg')
  map.controls[google.maps.ControlPosition.TOP_RIGHT].push(currentLocation );

  currentLocation.addEventListener('click', () => {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          var pos = {
            lat: position.coords.latitude,
            lng: position.coords.longitude,
          };
          map.setCenter(pos);
          // pinを更新
          updatePin(pos, map);
          // サークルを更新
          updateCircle(pos.lat, pos.lng, map);
          // フォームに値を入れる
          document.getElementById('lat').value = pos.lat;
          document.getElementById('lng').value = pos.lng;
        },
        (error) => {
          var errorInfo = [
            '原因不明のエラーが発生しました',
            '位置情報の取得が許可されませんでした。設定を確認してください。',
            '電波状況などで位置情報が取得できませんでした',
            '位置情報の取得に時間がかかり過ぎてタイムアウトしました'
          ];
          var errorNum = error.code;

          var errorMessage = errorInfo[errorNum]

          alert(errorMessage);
        }
      );
    } else {
      window.alert('お使いの端末では対応しておりません...。');
    }
  });

  // 検索ボックス
  const input = document.getElementById("pac-input");
  const searchBox = new google.maps.places.SearchBox(input);
  // 左側に設置
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
  map.addListener("bounds_changed", () => {
    searchBox.setBounds(map.getBounds());
  });

  searchBox.addListener("places_changed", () => {
    const places = searchBox.getPlaces();

    if (places.length == 0) {
      return;
    }

    const bounds = new google.maps.LatLngBounds();

    places.forEach((place) => {
      if (!place.geometry || !place.geometry.location) {
        console.log("検索結果がありませんでした。");
        return;
      }

      if (place.geometry.viewport) {
        // Only geocodes have viewport.
        bounds.union(place.geometry.viewport);
      } else {
        bounds.extend(place.geometry.location);
      }
    });
    map.fitBounds(bounds);
    var zoom = map.getZoom();
    map.setZoom(zoom > 13 ? 13 : zoom);
  });

}
window.initMap = initMap;

clickMap = (lat_lng, map) => {
  lat = lat_lng.lat();
  lng = lat_lng.lng();

  lat = Math.floor(lat * 10000000) / 10000000;
  lng = Math.floor(lng * 10000000) / 10000000;

  //座標をhidden formに入力する
  document.getElementById('lat').value = lat;
  document.getElementById('lng').value = lng;

  //中心に移動
  map.panTo(lat_lng);

  // マーカーの更新
  updatePin(lat_lng, map);

  updateCircle(lat, lng, map);
}

updatePin = (pos, map) => {
  pin.setMap(null);
  pin = null;
  pin = new google.maps.Marker({
    position: pos,
    map: map
  });
}

updateCircle = (lat, lng, map) => {
  circle.setMap(null);
  circle = null;
  circle = new google.maps.Circle({
    center: new google.maps.LatLng(lat, lng),
    map: map,
    radius: 1500,
    clickable: false,
    fillColor: '#297EDD',
    fillOpacity: 0.1,
    strokeColor: '#297EDD',
    strokeOpacity: 0.6,
    strokeWeight: 0.7,
  });
}
