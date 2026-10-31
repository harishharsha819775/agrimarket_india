import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/gemini_service.dart';

class DiseaseDetectionScreen extends StatefulWidget {
  const DiseaseDetectionScreen({super.key});

  @override
  State<DiseaseDetectionScreen> createState() => _DiseaseDetectionScreenState();
}

class _DiseaseDetectionScreenState extends State<DiseaseDetectionScreen> {
  final ImagePicker picker = ImagePicker();
  bool isLoading = false;
  String result = "";

  final GeminiService geminiService = GeminiService();
  XFile? selectedImage;
  Uint8List? imageBytes;

  Future<void> pickFromGallery() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image != null) {
      final bytes = await image.readAsBytes();

      setState(() {
        selectedImage = image;
        imageBytes = bytes;
      });
    }
  }

  Future<void> pickFromCamera() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );

    if (image != null) {
      final bytes = await image.readAsBytes();

      setState(() {
        selectedImage = image;
        imageBytes = bytes;
      });
    }
  }

  Future<void> detectDisease() async {
    if (imageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an image first.")),
      );
      return;
    }

    setState(() {
      isLoading = true;
      result = "";
    });

    final response = await geminiService.detectDisease(imageBytes!);

    setState(() {
      result = response;
      isLoading = false;
    });
  }

  Widget actionButton(
    String text,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🌿 AI Disease Detection"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(15),
            ),
            child: imageBytes == null
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, size: 80, color: Colors.grey),
                        SizedBox(height: 10),
                        Text(
                          "No Image Selected",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.memory(imageBytes!, fit: BoxFit.cover),
                  ),
          ),

          const SizedBox(height: 25),

          actionButton(
            "Choose From Gallery",
            Icons.photo,
            Colors.blue,
            pickFromGallery,
          ),

          const SizedBox(height: 15),

          actionButton(
            "Take Photo",
            Icons.camera_alt,
            Colors.orange,
            pickFromCamera,
          ),

          const SizedBox(height: 25),

          actionButton(
            "Detect Disease",
            Icons.health_and_safety,
            Colors.green,
            detectDisease,
          ),
          const SizedBox(height: 25),

          if (isLoading) const Center(child: CircularProgressIndicator()),
          const SizedBox(height: 20),

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
                  style: const TextStyle(fontSize: 16, height: 1.6),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
