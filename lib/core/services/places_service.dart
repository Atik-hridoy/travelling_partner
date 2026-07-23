import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../services/app_logger.dart';

class PlacesService {
  /// Fetch autocomplete suggestions for [input] using ApiConstants URL
  Future<List<String>> getAutocomplete(String input) async {
    if (input.isEmpty) return [];

    // All URLs centralized in ApiConstants
    final url = Uri.parse(ApiConstants.googlePlacesAutocompleteUrl(input));

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          final predictions = data['predictions'] as List;
          return predictions
              .map((p) => p['description'] as String)
              .toList();
        } else if (data['status'] == 'REQUEST_DENIED') {
          AppLogger.error(
              'Google Places API Error',
              data['error_message'] ?? 'Request Denied');
          return [];
        }
      }
      return [];
    } catch (e) {
      AppLogger.error('Error fetching places', e);
      return [];
    }
  }
}
