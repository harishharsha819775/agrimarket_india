import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  Future<List<dynamic>> getNews() async {
    final url = Uri.parse(
      'https://newsapi.org/v2/everything?q=agriculture%20OR%20farming%20OR%20crops&language=en&sortBy=publishedAt&apiKey=e14fa88de33c49a8adc6a99bea929f70',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["articles"];
    } else {
      throw Exception("Failed to load news");
    }
  }
}
