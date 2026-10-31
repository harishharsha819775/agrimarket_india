import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SchemeDetailsScreen extends StatelessWidget {
  final String title;
  final String description;
  final String eligibility;
  final String benefits;
  final String documents;
  final String website;

  const SchemeDetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.eligibility,
    required this.benefits,
    required this.documents,
    required this.website,
  });

  Widget infoCard(String heading, String content, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(
          heading,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(content),
      ),
    );
  }

  Future<void> openWebsite() async {
    final Uri url = Uri.parse(website);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          infoCard("Description", description, Icons.description),

          infoCard("Eligibility", eligibility, Icons.person),

          infoCard("Benefits", benefits, Icons.star),

          infoCard("Required Documents", documents, Icons.folder),

          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: openWebsite,
            icon: const Icon(Icons.open_in_browser),
            label: const Text("Visit Official Website"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 55),
            ),
          ),
        ],
      ),
    );
  }
}
