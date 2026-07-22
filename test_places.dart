import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  const apiKey = 'AIzaSyDtoM2PFII8A8v2PXIxL9ITj1evfIdBb0Y';
  final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=Japan&key=$apiKey&types=(regions)');
  
  try {
    print('Fetching from Google Places API...');
    final response = await http.get(url);
    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');
  } catch (e) {
    print('Error: $e');
  }
}
