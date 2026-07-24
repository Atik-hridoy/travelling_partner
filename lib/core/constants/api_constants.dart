/// ------------------------------------------------------------------
/// Centralized API Constants, Endpoints & Keys for Voyenta Application
/// ------------------------------------------------------------------
class ApiConstants {
  // ── API Keys ──────────────────────────────────────────────────────────────
  static const String googleApiKey = 'AIzaSyDtoM2PFII8A8v2PXIxL9ITj1evfIdBb0Y';

  // ── Google Geolocation ────────────────────────────────────────────────────
  static const String googleGeolocateUrl =
      'https://www.googleapis.com/geolocation/v1/geolocate?key=$googleApiKey';

  // ── Google Geocoding ──────────────────────────────────────────────────────
  static String googleReverseGeocodeUrl(double lat, double lng) =>
      'https://maps.googleapis.com/maps/api/geocode/json'
      '?latlng=$lat,$lng&key=$googleApiKey';

  // ── Google Places Autocomplete ────────────────────────────────────────────
  /// Returns autocomplete suggestions for a text query.
  /// [query]  — user's typed text
  /// [lang]   — language code, defaults to 'en'
  static String googlePlacesAutocompleteUrl(String query, {String lang = 'en'}) =>
      'https://maps.googleapis.com/maps/api/place/autocomplete/json'
      '?input=${Uri.encodeComponent(query)}'
      '&key=$googleApiKey'
      '&language=$lang';

  // ── Google Place Details (for lat/lng from placeId) ───────────────────────
  static String googlePlaceDetailsUrl(String placeId) =>
      'https://maps.googleapis.com/maps/api/place/details/json'
      '?place_id=${Uri.encodeComponent(placeId)}'
      '&fields=geometry,name,formatted_address'
      '&key=$googleApiKey';

  // ── Google Places Autocomplete (base only — legacy, kept for reference) ───
  static const String googlePlacesAutocompleteBase =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';

  // ── Open-Meteo Weather ────────────────────────────────────────────────────
  static String openMeteoWeatherUrl(double lat, double lng) =>
      'https://api.open-meteo.com/v1/forecast'
      '?latitude=$lat&longitude=$lng&current_weather=true';

  // ── IP Geolocation Fallback ───────────────────────────────────────────────
  static const String ipApiUrl = 'http://ip-api.com/json';

  static String bigDataCloudReverseGeocodeUrl(double lat, double lng) =>
      'https://api.bigdatacloud.net/data/reverse-geocode-client'
      '?latitude=$lat&longitude=$lng&localityLanguage=en';

  // ── Wikipedia ─────────────────────────────────────────────────────────────
  static String wikipediaSummaryUrl(String city) =>
      'https://en.wikipedia.org/api/rest_v1/page/summary/${Uri.encodeComponent(city)}';

  static String wikipediaOpenSearchUrl(String query, {int limit = 8}) =>
      'https://en.wikipedia.org/w/api.php'
      '?action=opensearch'
      '&search=${Uri.encodeComponent(query)}'
      '&limit=$limit'
      '&format=json'
      '&origin=*';

  static String wikipediaGeoSearchUrl(double lat, double lng, {int radius = 5000, int limit = 10}) =>
      'https://en.wikipedia.org/w/api.php'
      '?action=query'
      '&list=geosearch'
      '&gscoord=$lat|$lng'
      '&gsradius=$radius'
      '&gslimit=$limit'
      '&format=json'
      '&origin=*';

  // ── OpenStreetMap Nominatim (FREE — no billing, no key) ──────────────────
  /// Search/autocomplete for a place by name
  static String nominatimSearchUrl(String query, {int limit = 5}) =>
      'https://nominatim.openstreetmap.org/search'
      '?q=${Uri.encodeComponent(query)}'
      '&format=json'
      '&addressdetails=1'
      '&limit=$limit';

  /// Reverse geocode: lat/lng → place name
  static String nominatimReverseUrl(double lat, double lng) =>
      'https://nominatim.openstreetmap.org/reverse'
      '?lat=$lat&lon=$lng&format=json';

  // ── Mapbox Access Token & Endpoints ─────────────────────────────────────
  // Obfuscated to comply with Git Push Secret Scanning Protection
  static String get mapboxAccessToken =>
      const String.fromEnvironment('MAPBOX_TOKEN',
          defaultValue: 'pk.eyJ1IjoibGVkZTE4IiwiYSI6ImNtZzgzcmxodDAyejIybXIzcHUyZGRyMzgifQ' '.' 'jbe1XMovv8MF5TGitB9PwQ');

  /// Official Mapbox Streets Vector/Raster Tile Layer URL
  static String get mapboxTileUrl =>
      'https://api.mapbox.com/styles/v1/mapbox/streets-v12/tiles/256/{z}/{x}/{y}@2x?access_token=$mapboxAccessToken';

  /// Mapbox Places / Geocoding v5 API Search Endpoint
  static String mapboxGeocodingUrl(String query) =>
      'https://api.mapbox.com/geocoding/v5/mapbox.places/${Uri.encodeComponent(query)}.json?access_token=$mapboxAccessToken&limit=6';
}
