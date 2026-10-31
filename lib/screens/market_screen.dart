import 'package:flutter/material.dart';
import '../data/states.dart';
import '../data/districts.dart';
import '../data/taluks.dart';
import '../data/crops.dart';
import '../data/prices.dart';
import '../data/markets.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  String? selectedState;
  String? selectedDistrict;
  String? selectedTaluk;
  Crop? selectedCrop;

  bool showResult = false;

  String marketPrice = "₹ 2,450 / Quintal";
  String marketName = "Mysuru APMC";
  String updatedDate = "Today";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,

        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "💰 Live Market Prices",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "Latest APMC Rates",
              style: TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),

        toolbarHeight: 70,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              "Select Location",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // State
            DropdownButtonFormField<String>(
              value: selectedState,
              decoration: const InputDecoration(
                labelText: "State",
                border: OutlineInputBorder(),
              ),
              items: indianStates.map((state) {
                return DropdownMenuItem(value: state, child: Text(state));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedState = value;
                  selectedDistrict = null;
                  selectedTaluk = null;
                });
              },
            ),

            const SizedBox(height: 15),

            // District
            DropdownButtonFormField<String>(
              value: selectedDistrict,
              decoration: const InputDecoration(
                labelText: "District",
                border: OutlineInputBorder(),
              ),
              items: (districts[selectedState] ?? []).map((district) {
                return DropdownMenuItem(value: district, child: Text(district));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDistrict = value;
                  selectedTaluk = null;
                });
              },
            ),

            const SizedBox(height: 15),

            // Taluk
            DropdownButtonFormField<String>(
              value: selectedTaluk,
              decoration: const InputDecoration(
                labelText: "Taluk",
                border: OutlineInputBorder(),
              ),
              items: (taluks[selectedDistrict] ?? []).map((taluk) {
                return DropdownMenuItem(value: taluk, child: Text(taluk));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedTaluk = value;
                });
              },
            ),

            const SizedBox(height: 15),

            // Crop
            DropdownButtonFormField<Crop>(
              value: selectedCrop,
              decoration: const InputDecoration(
                labelText: "Crop",
                border: OutlineInputBorder(),
              ),
              items: crops.map((crop) {
                return DropdownMenuItem<Crop>(
                  value: crop,
                  child: Text(crop.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCrop = value;
                });
              },
            ),

            const SizedBox(height: 30),

            // Search Button
            // Search Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.search),
                label: const Text(
                  "Search Prices",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  if (selectedState == null ||
                      selectedDistrict == null ||
                      selectedTaluk == null ||
                      selectedCrop == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Please select State, District, Taluk and Crop.",
                        ),
                      ),
                    );
                    return;
                  }

                  setState(() {
                    marketPrice =
                        cropPrices[selectedCrop!.name] ?? "Price Not Available";

                    marketName =
                        markets[selectedDistrict] ?? "Market Not Available";

                    updatedDate = "Today";

                    showResult = true;
                  });
                },
              ),
            ),

            const SizedBox(height: 25),

            // Result Card
            if (showResult)
              Card(
                elevation: 10,
                shadowColor: Colors.green.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "🌾 Crop: ${selectedCrop!.name}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          const Icon(Icons.location_city, color: Colors.green),
                          const SizedBox(width: 10),
                          Expanded(child: Text("State: $selectedState")),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          const Icon(Icons.map, color: Colors.orange),
                          const SizedBox(width: 10),
                          Expanded(child: Text("District: $selectedDistrict")),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          const Icon(Icons.place, color: Colors.red),
                          const SizedBox(width: 10),
                          Expanded(child: Text("Taluk: $selectedTaluk")),
                        ],
                      ),

                      const Divider(height: 30),

                      const Text(
                        "💰 Today's Price",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Text(
                          marketPrice,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      const SizedBox(height: 15),

                      Row(
                        children: [
                          const Icon(Icons.store, color: Colors.brown),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Market: $marketName",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          const Icon(Icons.update, color: Colors.blue),
                          const SizedBox(width: 10),
                          Text(
                            "Updated: $updatedDate",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
