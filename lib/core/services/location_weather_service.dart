import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../services/app_logger.dart';
import '../../features/dashboard/home/widgets/weather_widget.dart';

class LocationWeatherData {
  final String locationName;
  final String temperature;
  final String conditionName;
  final WeatherType weatherType;

  LocationWeatherData({
    required this.locationName,
    required this.temperature,
    required this.conditionName,
    required this.weatherType,
  });
}

class LocationWeatherService {
  /// Bulletproof & resilient location and weather retrieval
  static Future<LocationWeatherData> fetchLiveWeatherAndLocation() async {
    double? lat;
    double? lng;
    String? realCity;
    String? realCountry;

    AppLogger.info('Initiating resilient phone GPS trace...', tag: 'GPS_TRACE');

    // Tier 1: Try Device Hardware Last Known Position (Instant)
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (serviceEnabled) {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        }

        if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
          Position? lastKnown = await Geolocator.getLastKnownPosition();
          if (lastKnown != null) {
            lat = lastKnown.latitude;
            lng = lastKnown.longitude;
            AppLogger.success('Device Last Known GPS: lat=$lat, lng=$lng', tag: 'GPS_LAST_KNOWN');
          } else {
            Position current = await Geolocator.getCurrentPosition(
              locationSettings: const LocationSettings(
                accuracy: LocationAccuracy.medium,
                timeLimit: Duration(seconds: 4),
              ),
            );
            lat = current.latitude;
            lng = current.longitude;
            AppLogger.success('Device Current GPS: lat=$lat, lng=$lng', tag: 'GPS_CURRENT');
          }
        }
      }
    } catch (e) {
      AppLogger.error('Hardware GPS Sensor Notice', e);
    }

    // Tier 2: Try Google Maps Geolocation API
    if (lat == null || lng == null) {
      try {
        final geoUrl = Uri.parse(ApiConstants.googleGeolocateUrl);
        final geoResponse = await http.post(
          geoUrl,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'considerIp': true}),
        ).timeout(const Duration(seconds: 3));

        if (geoResponse.statusCode == 200) {
          final geoData = json.decode(geoResponse.body);
          if (geoData['location'] != null) {
            lat = (geoData['location']['lat'] as num).toDouble();
            lng = (geoData['location']['lng'] as num).toDouble();
            AppLogger.success('Google Geolocation Fallback: lat=$lat, lng=$lng', tag: 'GPS_GOOGLE');
          }
        }
      } catch (e) {
        AppLogger.error('Google Geolocation Notice', e);
      }
    }

    // Tier 3: Try IP Geolocation
    if (lat == null || lng == null) {
      try {
        final ipUrl = Uri.parse(ApiConstants.ipApiUrl);
        final ipResponse = await http.get(ipUrl).timeout(const Duration(seconds: 3));
        if (ipResponse.statusCode == 200) {
          final ipData = json.decode(ipResponse.body);
          if (ipData['status'] == 'success') {
            lat = (ipData['lat'] as num).toDouble();
            lng = (ipData['lon'] as num).toDouble();
            realCity = ipData['city'] ?? ipData['regionName'];
            realCountry = ipData['country'];
          }
        }
      } catch (e) {
        AppLogger.error('IP Geolocation Notice', e);
      }
    }

    // Fallback coordinates if everything failed
    lat ??= 23.8103;
    lng ??= 90.4125;

    // Step 2: Reverse Geocoding to get City & Country
    if (realCity == null || realCountry == null) {
      try {
        final placemarks = await placemarkFromCoordinates(lat, lng).timeout(const Duration(seconds: 3));
        if (placemarks.isNotEmpty) {
          final p = placemarks.first;
          realCity = p.locality ?? p.subAdministrativeArea ?? p.administrativeArea ?? p.subLocality ?? p.name;
          realCountry = p.country;
        }
      } catch (_) {}

      if (realCity == null || realCity.isEmpty) {
        try {
          final reverseUrl = Uri.parse(ApiConstants.googleReverseGeocodeUrl(lat, lng));
          final revResponse = await http.get(reverseUrl).timeout(const Duration(seconds: 3));
          if (revResponse.statusCode == 200) {
            final revData = json.decode(revResponse.body);
            if (revData['status'] == 'OK' && (revData['results'] as List).isNotEmpty) {
              final components = revData['results'][0]['address_components'] as List;
              for (var c in components) {
                final types = c['types'] as List;
                if (types.contains('locality') || types.contains('sublocality') || types.contains('administrative_area_level_2')) {
                  realCity = c['long_name'];
                }
                if (types.contains('country')) {
                  realCountry = c['long_name'];
                }
              }
            }
          }
        } catch (_) {}
      }
    }

    final String finalLocationName = (realCity != null && realCountry != null)
        ? '$realCity, $realCountry'
        : (realCity ?? realCountry ?? 'Bangladesh');

    AppLogger.success('Location Resolved: "$finalLocationName" ($lat, $lng)', tag: 'LOCATION_RESOLVED');

    // Step 3: Fetch Open-Meteo Live Weather
    try {
      final weatherUrl = Uri.parse(ApiConstants.openMeteoWeatherUrl(lat, lng));
      final weatherResponse = await http.get(weatherUrl).timeout(const Duration(seconds: 4));

      if (weatherResponse.statusCode == 200) {
        final data = json.decode(weatherResponse.body);
        final currentWeather = data['current_weather'];

        final double tempC = (currentWeather['temperature'] as num).toDouble();
        final int code = (currentWeather['weathercode'] as num).toInt();

        final int tempCInt = tempC.round();
        final String tempString = '$tempCInt°C';

        final WeatherType type = _mapCodeToWeatherType(code);
        final String condition = _mapCodeToConditionName(code);

        AppLogger.success('Weather Resolved: $tempString $condition for "$finalLocationName"', tag: 'WEATHER_RESOLVED');

        return LocationWeatherData(
          locationName: finalLocationName,
          temperature: tempString,
          conditionName: condition,
          weatherType: type,
        );
      }
    } catch (e) {
      AppLogger.error('Weather Resolution Notice', e);
    }

    return LocationWeatherData(
      locationName: finalLocationName,
      temperature: '26°C',
      conditionName: 'Clear',
      weatherType: WeatherType.sunny,
    );
  }

  static WeatherType _mapCodeToWeatherType(int code) {
    if (code == 0 || code == 1) return WeatherType.sunny;
    if (code == 2 || code == 3) return WeatherType.cloudy;
    if (code >= 51 && code <= 67) return WeatherType.rainy;
    if (code >= 71 && code <= 77) return WeatherType.snowy;
    if (code >= 95) return WeatherType.thunder;
    return WeatherType.sunny;
  }

  static String _mapCodeToConditionName(int code) {
    if (code == 0) return 'Clear';
    if (code == 1) return 'Sunny';
    if (code == 2) return 'Partly Cloudy';
    if (code == 3) return 'Overcast';
    if (code >= 51 && code <= 67) return 'Rainy';
    if (code >= 71 && code <= 77) return 'Snowy';
    if (code >= 95) return 'Stormy';
    return 'Clear';
  }
}
