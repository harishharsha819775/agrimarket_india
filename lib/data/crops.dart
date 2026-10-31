class Crop {
  final String name;
  final String category;
  final String image;

  const Crop({required this.name, required this.category, required this.image});
}

const List<Crop> crops = [
  // Cereals
  Crop(name: "Rice", category: "Cereals", image: "assets/images/rice.jpg"),
  Crop(name: "Wheat", category: "Cereals", image: "assets/images/wheat.jpg"),
  Crop(name: "Maize", category: "Cereals", image: "assets/images/maize.jpg"),

  // Vegetables
  Crop(
    name: "Tomato",
    category: "Vegetables",
    image: "assets/images/tomato.jpg",
  ),
  Crop(name: "Onion", category: "Vegetables", image: "assets/images/onion.jpg"),
  Crop(
    name: "Potato",
    category: "Vegetables",
    image: "assets/images/potato.jpg",
  ),

  // Fruits
  Crop(name: "Mango", category: "Fruits", image: "assets/images/mango.jpg"),
  Crop(name: "Banana", category: "Fruits", image: "assets/images/banana.jpg"),

  // Commercial
  Crop(
    name: "Cotton",
    category: "Commercial",
    image: "assets/images/cotton.jpg",
  ),
  Crop(
    name: "Sugarcane",
    category: "Commercial",
    image: "assets/images/sugarcane.jpg",
  ),
];
