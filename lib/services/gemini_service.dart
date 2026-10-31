import 'dart:typed_data';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  // Replace with your Gemini API Key
  static  const String apiKey = 'YOUR_API_KEY';

  final GenerativeModel model = GenerativeModel(
    model: "gemini-2.0-flash",
    apiKey: apiKey,
  );

  // ===========================
  // 🌿 Disease Detection
  // ===========================
  Future<String> detectDisease(Uint8List imageBytes) async {
    try {
      final prompt = TextPart("""
You are an agricultural expert.

Analyze this crop leaf image.

Return ONLY in this exact format:

Disease:
...

Symptoms:
...

Treatment:
...

Prevention:
...

If the image is not a plant leaf, reply:

This is not a valid crop leaf image.
""");

      final image = DataPart("image/jpeg", imageBytes);

      final response = await model.generateContent([
        Content.multi([prompt, image]),
      ]);

      return response.text ?? "No response from AI.";
    } catch (e) {
      return "Error: $e";
    }
  }

  // ===========================
  // 🤖 AI Farmer Assistant
  // ===========================
  Future<String> askFarmerAssistant(String question) async {
    try {
      final prompt =
          """
You are an expert Indian agricultural assistant.

Answer the farmer's question in a simple, practical, and easy-to-understand way.

If applicable, include:

🌱 Explanation
🐛 Possible Causes
✅ Solution
🛡 Prevention

Farmer's Question:

$question
""";

      final response = await model.generateContent([Content.text(prompt)]);

      return response.text ?? "No response from AI.";
    } catch (e) {
      return "Error: $e";
    }
  }

  // ===========================
  // 🌾 Crop Recommendation
  // ===========================
  Future<String> recommendCrop({
    required String temperature,
    required String humidity,
    required String rainfall,
    required String soil,
    required String state,
  }) async {
    try {
      final prompt =
          """
You are an expert agricultural officer in India.

Based on the following data:

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

      final response = await model.generateContent([Content.text(prompt)]);

      return response.text ?? "No response from AI.";
    } catch (e) {
      return "Error: $e";
    }
  }
}
