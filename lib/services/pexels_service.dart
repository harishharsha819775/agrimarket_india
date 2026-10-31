import 'dart:convert';
import 'package:http/http.dart' as http;

class PexelsService {
  // Replace with your NEW Pexels API key
  static const String apiKey =
      "FphLIO9X123ICFTxBr0ZGPYIrhYskLsnSwM8cZxuggNCYlcK0xnmS7NU";

  Future<String?> getCropImage(String cropName) async {
    final url = Uri.parse(
      "https://api.pexels.com/v1/search?query=$cropName%20crop&per_page=1",
    );

    final response = await http.get(url, headers: {"Authorization": apiKey});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data["photos"] != null && data["photos"].isNotEmpty) {
        return data["photos"][0]["src"]["large"];
      }
    }

    return null;
  }
}
