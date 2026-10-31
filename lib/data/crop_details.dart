class CropDetail {
  final String name;
  final String image;
  final String description;
  final String soil;
  final String season;
  final String temperature;
  final String water;
  final String fertilizer;
  final String diseases;
  final String harvest;

  CropDetail({
    required this.name,
    required this.image,
    required this.description,
    required this.soil,
    required this.season,
    required this.temperature,
    required this.water,
    required this.fertilizer,
    required this.diseases,
    required this.harvest,
  });
}

final Map<String, CropDetail> cropDetails = {
  "Rice": CropDetail(
    name: "Rice",
    image: "assets/images/rice.jpg",
    description:
        "Rice is India's most important food crop and a staple for millions of people.",
    soil: "Clayey and loamy soil",
    season: "Kharif",
    temperature: "20°C - 35°C",
    water: "High",
    fertilizer: "NPK + Urea",
    diseases: "Blast, Brown Spot",
    harvest: "110 - 150 Days",
  ),

  "Wheat": CropDetail(
    name: "Wheat",
    image: "assets/images/wheat.jpg",
    description: "Wheat is the second most important cereal crop in India.",
    soil: "Well-drained loamy soil",
    season: "Rabi",
    temperature: "15°C - 25°C",
    water: "Medium",
    fertilizer: "NPK + Nitrogen",
    diseases: "Rust, Smut",
    harvest: "120 - 140 Days",
  ),

  "Maize": CropDetail(
    name: "Maize",
    image: "assets/images/maize.jpg",
    description:
        "Maize is widely used for food, fodder and industrial products.",
    soil: "Fertile loamy soil",
    season: "Kharif / Rabi",
    temperature: "18°C - 27°C",
    water: "Medium",
    fertilizer: "NPK",
    diseases: "Leaf Blight, Downy Mildew",
    harvest: "90 - 120 Days",
  ),
};
