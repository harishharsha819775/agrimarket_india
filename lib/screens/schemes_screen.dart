import 'package:flutter/material.dart';
import 'scheme_details_screen.dart';

class SchemesScreen extends StatelessWidget {
  const SchemesScreen({super.key});

  final List<Map<String, dynamic>> schemes = const [
    {
      "title": "PM-KISAN",
      "subtitle": "Income support scheme for farmers.",
      "icon": Icons.account_balance,
      "color": Colors.green,
      "description":
          "PM-KISAN provides ₹6,000 per year to eligible farmer families in three installments.",
      "eligibility": "Small and marginal farmers owning cultivable land.",
      "benefits": "₹6,000 annually transferred directly to the bank account.",
      "documents": "Aadhaar Card, Bank Passbook, Land Records.",
      "website": "https://pmkisan.gov.in",
    },

    {
      "title": "PM Fasal Bima Yojana",
      "subtitle": "Crop insurance scheme.",
      "icon": Icons.shield,
      "color": Colors.orange,
      "description":
          "Provides insurance coverage against crop failure due to natural disasters.",
      "eligibility": "All farmers growing notified crops.",
      "benefits": "Financial protection against crop loss.",
      "documents": "Aadhaar, Bank Account, Land Details.",
      "website": "https://pmfby.gov.in",
    },

    {
      "title": "Kisan Credit Card",
      "subtitle": "Agricultural loans for farmers.",
      "icon": Icons.credit_card,
      "color": Colors.blue,
      "description":
          "Provides easy and affordable credit for agricultural needs.",
      "eligibility": "Farmers involved in agriculture and allied activities.",
      "benefits": "Low-interest crop loans.",
      "documents": "Aadhaar, PAN, Land Records.",
      "website": "https://www.myscheme.gov.in",
    },

    {
      "title": "Soil Health Card",
      "subtitle": "Know your soil nutrients.",
      "icon": Icons.grass,
      "color": Colors.brown,
      "description":
          "Provides detailed information about soil nutrients and fertilizer recommendations.",
      "eligibility": "All farmers.",
      "benefits": "Improves crop productivity and soil health.",
      "documents": "Aadhaar Card.",
      "website": "https://soilhealth.dac.gov.in",
    },

    {
      "title": "PM Krishi Sinchai Yojana",
      "subtitle": "Irrigation support.",
      "icon": Icons.water_drop,
      "color": Colors.cyan,
      "description": "Promotes efficient irrigation and water conservation.",
      "eligibility": "Eligible farmers.",
      "benefits": "Financial assistance for irrigation facilities.",
      "documents": "Land Records, Aadhaar.",
      "website": "https://pmksy.gov.in",
    },

    {
      "title": "e-NAM",
      "subtitle": "National Agriculture Market.",
      "icon": Icons.store,
      "color": Colors.deepPurple,
      "description":
          "Online trading platform connecting agricultural markets across India.",
      "eligibility": "Farmers, Traders, FPOs.",
      "benefits": "Better market access and transparent pricing.",
      "documents": "Aadhaar and Bank Account.",
      "website": "https://enam.gov.in",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🏛 Government Schemes"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: schemes.length,
        itemBuilder: (context, index) {
          final scheme = schemes[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: scheme["color"],
                child: Icon(scheme["icon"], color: Colors.white),
              ),
              title: Text(
                scheme["title"],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(scheme["subtitle"]),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SchemeDetailsScreen(
                      title: scheme["title"],
                      description: scheme["description"],
                      eligibility: scheme["eligibility"],
                      benefits: scheme["benefits"],
                      documents: scheme["documents"],
                      website: scheme["website"],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
