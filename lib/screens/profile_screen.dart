import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController cropController = TextEditingController();
  final TextEditingController landController = TextEditingController();
  final TextEditingController soilController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      nameController.text = prefs.getString('name') ?? '';
      phoneController.text = prefs.getString('phone') ?? '';
      stateController.text = prefs.getString('state') ?? '';
      districtController.text = prefs.getString('district') ?? '';
      villageController.text = prefs.getString('village') ?? '';
      cropController.text = prefs.getString('crop') ?? '';
      landController.text = prefs.getString('land') ?? '';
      soilController.text = prefs.getString('soil') ?? '';
    });
  }

  Future<void> saveProfile() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('name', nameController.text);
    await prefs.setString('phone', phoneController.text);
    await prefs.setString('state', stateController.text);
    await prefs.setString('district', districtController.text);
    await prefs.setString('village', villageController.text);
    await prefs.setString('crop', cropController.text);
    await prefs.setString('land', landController.text);
    await prefs.setString('soil', soilController.text);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("✅ Profile Saved Successfully!"),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget textField(
    String label,
    IconData icon,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.green),
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    stateController.dispose();
    districtController.dispose();
    villageController.dispose();
    cropController.dispose();
    landController.dispose();
    soilController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("👤 Farmer Profile"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(
            radius: 55,
            backgroundColor: Colors.green,
            child: Icon(Icons.person, size: 60, color: Colors.white),
          ),

          const SizedBox(height: 25),

          textField("Farmer Name", Icons.person, nameController),
          textField("Mobile Number", Icons.phone, phoneController),
          textField("State", Icons.map, stateController),
          textField("District", Icons.location_city, districtController),
          textField("Village", Icons.home, villageController),

          const Divider(height: 35),

          textField("Main Crop", Icons.agriculture, cropController),
          textField("Land Size (Acres)", Icons.landscape, landController),
          textField("Soil Type", Icons.grass, soilController),

          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: saveProfile,
            icon: const Icon(Icons.save),
            label: const Text("Save Profile"),
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
