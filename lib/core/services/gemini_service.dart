import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/app_logger.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// GroqService — FREE AI itinerary generation using Groq + Llama 3.3
/// Free tier: 14,400 requests/day — console.groq.com
/// ─────────────────────────────────────────────────────────────────────────────
class GroqService {
  GroqService._();

  // Get your FREE key at: https://console.groq.com/keys
  static const String _apiKey = 'YOUR_GROQ_KEY_HERE';
  static const String _baseUrl = 'https://api.groq.com/openai/v1/chat/completions';
  static const String _model = 'llama-3.3-70b-versatile';

  static bool get isConfigured =>
      _apiKey.isNotEmpty && !_apiKey.startsWith('YOUR_');

  static Future<String?> generateDayPlan({
    required String city,
    required String country,
    required List<String> travelStyles,
    String? locationContext,
  }) async {
    if (!isConfigured) return null;

    final stylesText = travelStyles.isNotEmpty
        ? travelStyles.join(', ')
        : 'general sightseeing';

    final prompt = '''Generate a curated one-day itinerary for $city, $country.
Travel style: $stylesText.
${locationContext != null && locationContext.isNotEmpty ? 'Context: $locationContext' : ''}

Return ONLY a valid JSON array with exactly 5 stops. No markdown. No explanation.
Format:
[
  {"timeTag":"08:30 AM — MORNING","title":"Real Place Name","description":"2-3 vivid sentences.","novaInsight":"One hyperlocal insider tip.","category":"nature","distanceKm":"1.2"},
  {"timeTag":"10:30 AM — LATE MORNING","title":"...","description":"...","novaInsight":"...","category":"culture","distanceKm":"2.5"},
  {"timeTag":"01:00 PM — LUNCH","title":"...","description":"...","novaInsight":"...","category":"food","distanceKm":"0.8"},
  {"timeTag":"03:30 PM — AFTERNOON","title":"...","description":"...","novaInsight":"...","category":"leisure","distanceKm":"3.1"},
  {"timeTag":"06:45 PM — EVENING","title":"...","description":"...","novaInsight":"...","category":"evening","distanceKm":"2.0"}
]
Use REAL places in $city. Be specific and hyperlocal.''';

    try {
      AppLogger.info('🤖 Calling Groq AI (Llama 3.3) for $city...', tag: 'GROQ_REQ');
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: json.encode({
          'model': _model,
          'messages': [
            {
              'role': 'system',
              'content':
                  'You are Nova, an elite AI travel concierge. Always respond with valid JSON only.'
            },
            {'role': 'user', 'content': prompt},
          ],
          'temperature': 0.7,
          'max_tokens': 1200,
        }),
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final String? content =
            data['choices']?[0]?['message']?['content'] as String?;
        if (content != null && content.isNotEmpty) {
          AppLogger.success('✨ Groq AI response received (${content.length} chars)', tag: 'GROQ_OK');
          return content.trim();
        }
      } else {
        AppLogger.error('Groq HTTP ${response.statusCode}', response.body);
      }
    } catch (e) {
      AppLogger.error('Groq API Error', e);
    }
    return null;
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// DeepSeekService — kept for reference (requires paid balance)
/// ─────────────────────────────────────────────────────────────────────────────
class DeepSeekService {
  DeepSeekService._();
  // HTTP 402: Insufficient Balance — use GroqService instead
  static bool get isConfigured => false;
}
