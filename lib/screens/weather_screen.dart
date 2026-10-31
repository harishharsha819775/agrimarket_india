import 'package:flutter/material.dart';
import '../services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService weatherService = WeatherService();

  final TextEditingController cityController = TextEditingController(
    text: "Bengaluru",
  );

  Map<String, dynamic>? weatherData;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadWeather();
  }

  Future<void> loadWeather() async {
    setState(() {
      isLoading = true;
    });

    try {
      final data = await weatherService.getWeather(cityController.text.trim());
      print(data);

      setState(() {
        weatherData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Unable to load weather.\n$e")));
    }
  }

  Widget infoCard(IconData icon, String title, String value) {
    return Expanded(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Icon(icon, size: 38, color: Colors.blue),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final main = weatherData?["main"];
    final weather = weatherData?["weather"] != null
        ? weatherData!["weather"][0]
        : null;
    final wind = weatherData?["wind"];

    return Scaffold(
      appBar: AppBar(
        title: const Text("🌦 Live Weather"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: cityController,
            decoration: InputDecoration(
              hintText: "Enter City (Example: Bengaluru)",
              prefixIcon: const Icon(Icons.location_city),
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: loadWeather,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onSubmitted: (_) => loadWeather(),
          ),

          const SizedBox(height: 20),

          if (isLoading) const Center(child: CircularProgressIndicator()),

          if (!isLoading && weatherData != null)
            Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        weatherData!["name"],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Image.network(
                        "https://openweathermap.org/img/wn/${weather["icon"]}@4x.png",
                        width: 120,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.cloud,
                            size: 80,
                            color: Colors.white,
                          );
                        },
                      ),

                      Text(
                        "${main["temp"]}°C",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        weather["main"],
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    infoCard(
                      Icons.water_drop,
                      "Humidity",
                      "${main["humidity"]}%",
                    ),
                    const SizedBox(width: 10),
                    infoCard(Icons.air, "Wind", "${wind["speed"]} m/s"),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    infoCard(
                      Icons.thermostat,
                      "Feels Like",
                      "${main["feels_like"]}°C",
                    ),
                    const SizedBox(width: 10),
                    infoCard(
                      Icons.compress,
                      "Pressure",
                      "${main["pressure"]} hPa",
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: loadWeather,
                  icon: const Icon(Icons.refresh),
                  label: const Text("Refresh Weather"),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
