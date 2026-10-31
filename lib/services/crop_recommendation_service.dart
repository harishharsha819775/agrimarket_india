import 'package:http/http.dart' as http;
import 'dart:convert';

class CropRecommendationService {
  static const String apiKey = 'YOUR_API_KEY';
  Future<String> recommendCrop({
    required String temperature,
    required String humidity,
    required String rainfall,
    required String soil,
    required String state,
  }) async {
    final url = Uri.parse(
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent",
    );

    final prompt =
        """
You are an expert agricultural officer in India.

Based on the following information:

Temperature: $temperature °C
Humidity: $humidity %
Rainfall: $rainfall mm
Soil Type: $soil
State: $state

Recommend the best crop.

Return ONLY in this format:

🌾 Recommended Crop:
...

📈 Reason:
...

🌱 Expected Yield:
...

💰 Market Potential:
...

💧 Irrigation Advice:
...
""";

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json", "x-goog-api-key": apiKey},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": prompt},
            ],
          },
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["candidates"][0]["content"]["parts"][0]["text"];
    } else {
      return "Error: ${response.body}";
    }
  }
}
