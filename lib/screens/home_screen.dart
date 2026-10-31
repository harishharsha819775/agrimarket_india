import 'package:flutter/material.dart';
import 'market_screen.dart';
import 'crop_screen.dart';
import 'weather_screen.dart';
import 'news_screen.dart';
import 'schemes_screen.dart';
import 'profile_screen.dart';
import 'disease_detection_screen.dart';
import 'crop_recommendation_screen.dart';
import 'chatbot_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget dashboardCard(
    BuildContext context,
    IconData icon,
    String title,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "🌾 AgriMarket India",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Welcome Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.green.shade600,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "👋 Welcome Farmer",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Check market prices, weather, crop information, disease detection and government schemes.",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),

            const Text(
              "📍 Select Location",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "State",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: "Karnataka", child: Text("Karnataka")),
              ],
              onChanged: (value) {},
            ),

            const SizedBox(height: 20),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.5,
              children: [
                dashboardCard(
                  context,
                  Icons.currency_rupee,
                  "Market Prices",
                  Colors.green,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MarketScreen()),
                    );
                  },
                ),

                dashboardCard(
                  context,
                  Icons.agriculture,
                  "Crop Info",
                  Colors.orange,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CropScreen()),
                    );
                  },
                ),

                dashboardCard(context, Icons.cloud, "Weather", Colors.blue, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const WeatherScreen()),
                  );
                }),

                dashboardCard(
                  context,
                  Icons.newspaper,
                  "News",
                  Colors.deepPurple,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const NewsScreen()),
                    );
                  },
                ),

                dashboardCard(
                  context,
                  Icons.account_balance,
                  "Schemes",
                  Colors.red,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SchemesScreen()),
                    );
                  },
                ),

                dashboardCard(
                  context,
                  Icons.person,
                  "Profile",
                  Colors.teal,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfileScreen()),
                    );
                  },
                ),

                dashboardCard(
                  context,
                  Icons.health_and_safety,
                  "Disease Detection",
                  Colors.green.shade800,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DiseaseDetectionScreen(),
                      ),
                    );
                  },
                ),

                dashboardCard(
                  context,
                  Icons.eco,
                  "Crop Recommendation",
                  Colors.lightGreen,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CropRecommendationScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
        elevation: 10,

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChatbotScreen()),
          );
        },

        icon: ClipOval(
          child: Image.asset(
            "assets/images/unnamed.png",
            width: 30,
            height: 30,
            fit: BoxFit.cover,
          ),
        ),

        label: const Text(
          "Ask AI",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
