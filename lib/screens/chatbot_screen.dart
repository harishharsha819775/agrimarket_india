import 'package:flutter/material.dart';
import '../services/gemini_service.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController messageController = TextEditingController();
  final GeminiService geminiService = GeminiService();

  String aiResponse = "";
  bool isLoading = false;

  Future<void> sendMessage() async {
    if (messageController.text.trim().isEmpty) return;

    setState(() {
      isLoading = true;
    });

    final response = await geminiService.askFarmerAssistant(
      messageController.text.trim(),
    );

    setState(() {
      aiResponse = response;
      isLoading = false;
    });

    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🤖 AI Farmer Assistant"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SelectableText(
                        aiResponse.isEmpty
                            ? "Ask me anything about farming 🌾"
                            : aiResponse,
                        style: const TextStyle(fontSize: 16),
                      ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: "Type your farming question...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  backgroundColor: Colors.green,
                  onPressed: sendMessage,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
