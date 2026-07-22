/// ------------------------------------------------------------------
/// Centralized API Constants, Endpoints & Keys for Voyenta Application
/// ------------------------------------------------------------------
class ApiConstants {
  // Google Maps API Key
  static const String googleApiKey = 'AIzaSyDtoM2PFII8A8v2PXIxL9ITj1evfIdBb0Y';

  // Google Maps Endpoints
  static const String googleGeolocateUrl =
      'https://www.googleapis.com/geolocation/v1/geolocate?key=$googleApiKey';

  static const String googlePlacesAutocompleteUrl =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';

  static String googleReverseGeocodeUrl(double lat, double lng) =>
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$googleApiKey';

  // Open-Meteo Weather Endpoint
  static String openMeteoWeatherUrl(double lat, double lng) =>
      'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lng&current_weather=true';

  // Fallback Geolocation Endpoints
  static const String ipApiUrl = 'http://ip-api.com/json';

  static String bigDataCloudReverseGeocodeUrl(double lat, double lng) =>
      'https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=$lat&longitude=$lng&localityLanguage=en';
}
