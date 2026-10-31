import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  // Replace with your OpenWeather API Key
  static const String apiKey = "e8cf8fa57ce3f8b6db9e2b0518533218";

  Future<Map<String, dynamic>> getWeather(String city) async {
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric",
    );

    print("Request URL: $url");

    final response = await http.get(url);

    print("Status Code: ${response.statusCode}");
    print("Response Body:");
    print(response.body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        "Failed to load weather.\n"
        "Status Code: ${response.statusCode}\n"
        "Response: ${response.body}",
      );
    }
  }
}
