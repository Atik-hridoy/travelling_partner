import 'dart:convert';
import 'package:http/http.dart' as http;

class PlacesService {
  // User's Google Maps API Key
  static const String _apiKey = 'AIzaSyDtoM2PFII8A8v2PXIxL9ITj1evfIdBb0Y';
  
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';

  Future<List<String>> getAutocomplete(String input) async {
    if (input.isEmpty) return [];

    final url = Uri.parse(
        '$_baseUrl?input=${Uri.encodeComponent(input)}&key=$_apiKey&types=(regions)');

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
          print('Google Places API Error: ${data['error_message']}');
          return [];
        }
      }
      // If we get ZERO_RESULTS or any error, just return empty
      return [];
    } catch (e) {
      print('Error fetching places: $e');
      return [];
    }
  }
}
