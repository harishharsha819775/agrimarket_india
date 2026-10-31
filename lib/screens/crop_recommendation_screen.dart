import 'package:flutter/material.dart';
import '../services/crop_recommendation_service.dart';
import '../services/pexels_service.dart';

class CropRecommendationScreen extends StatefulWidget {
  const CropRecommendationScreen({super.key});

  @override
  State<CropRecommendationScreen> createState() =>
      _CropRecommendationScreenState();
}

class _CropRecommendationScreenState extends State<CropRecommendationScreen> {
  final temperatureController = TextEditingController();
  final humidityController = TextEditingController();
  final rainfallController = TextEditingController();
  bool isLoading = false;
  String result = "";

  final CropRecommendationService cropService = CropRecommendationService();
  final PexelsService pexelsService = PexelsService();

  String? cropImageUrl;

  String selectedSoil = "Black Soil";
  String selectedState = "Karnataka";
  Future<void> recommendCrop() async {
    if (temperatureController.text.isEmpty ||
        humidityController.text.isEmpty ||
        rainfallController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields.")));
      return;
    }

    setState(() {
      isLoading = true;
      result = "";
    });

    final response = await cropService.recommendCrop(
      temperature: temperatureController.text,
      humidity: humidityController.text,
      rainfall: rainfallController.text,
      soil: selectedSoil,
      state: selectedState,
    );

    // Save AI response
    result = response;

    // Try to extract crop name
    String cropName = "";

    if (response.contains("Recommended Crop:")) {
      cropName = response.split("Recommended Crop:")[1].split("\n")[0].trim();
    }

    // Fetch crop image from Pexels
    if (cropName.isNotEmpty) {
      cropImageUrl = await pexelsService.getCropImage(cropName);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🌾 AI Crop Recommendation"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Enter Farm Details",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: temperatureController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Temperature (°C)",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 15),

          TextField(
            controller: humidityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Humidity (%)",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 15),

          TextField(
            controller: rainfallController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Rainfall (mm)",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 15),

          DropdownButtonFormField<String>(
            value: selectedSoil,
            decoration: const InputDecoration(
              labelText: "Soil Type",
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: "Black Soil", child: Text("Black Soil")),
              DropdownMenuItem(value: "Red Soil", child: Text("Red Soil")),
              DropdownMenuItem(
                value: "Alluvial Soil",
                child: Text("Alluvial Soil"),
              ),
              DropdownMenuItem(value: "Sandy Soil", child: Text("Sandy Soil")),
              DropdownMenuItem(value: "Clay Soil", child: Text("Clay Soil")),
            ],
            onChanged: (value) {
              setState(() {
                selectedSoil = value!;
              });
            },
          ),

          const SizedBox(height: 15),

          DropdownButtonFormField<String>(
            value: selectedState,
            decoration: const InputDecoration(
              labelText: "State",
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: "Karnataka", child: Text("Karnataka")),
              DropdownMenuItem(
                value: "Maharashtra",
                child: Text("Maharashtra"),
              ),
              DropdownMenuItem(value: "Tamil Nadu", child: Text("Tamil Nadu")),
              DropdownMenuItem(value: "Kerala", child: Text("Kerala")),
            ],
            onChanged: (value) {
              setState(() {
                selectedState = value!;
              });
            },
          ),

          const SizedBox(height: 25),

          SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              onPressed: recommendCrop,
              icon: const Icon(Icons.psychology),
              label: const Text("Recommend Crop"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),

          if (isLoading) const Center(child: CircularProgressIndicator()),
          const SizedBox(height: 20),

          if (cropImageUrl != null) ...[
            const SizedBox(height: 20),

            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                cropImageUrl!,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const SizedBox(
                    height: 220,
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 220,
                    alignment: Alignment.center,
                    color: Colors.grey.shade200,
                    child: const Text(
                      "Image not available",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
            ),
          ],
          if (result.isNotEmpty)
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  result,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
