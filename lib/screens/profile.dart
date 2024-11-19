import 'package:flutter/material.dart';
import 'aboutapp.dart';
import 'rateapp.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController(text: 'Nanda Zayyan Nurirfan');
  final TextEditingController nimController = TextEditingController(text: '21120122130079');
  final TextEditingController emailController = TextEditingController(text: 'nandazn123@gmail.com');
  final TextEditingController statusController = TextEditingController(text: 'Mahasiswa');
  final TextEditingController birthDateController = TextEditingController(text: '09-10-2003');

  bool isEditing = false;

  void toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void saveProfile() {
    setState(() {
      isEditing = false;
    });
    // Add save logic if needed
  }

  void _onMenuItemSelected(String value) {
    switch (value) {
      case 'edit':
        toggleEdit();
        break;
      case 'about':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AboutAppPage()),
        );
        break;
      case 'rate':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RateAppPage()),
        );
        break;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    nimController.dispose();
    emailController.dispose();
    statusController.dispose();
    birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          PopupMenuButton<String>(
            onSelected: _onMenuItemSelected,
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'edit',
                child: Text(isEditing ? 'Save Profile' : 'Edit Profile'),
              ),
              const PopupMenuItem<String>(
                value: 'about',
                child: Text('About App'),
              ),
              const PopupMenuItem<String>(
                value: 'rate',
                child: Text('Rate App'),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height, // Set height to screen height
          color: const Color.fromARGB(255, 24, 39, 51), // Full-screen background color
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 150.0,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF1F1C2C), Color(0xFF928DAB)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100.0,
                    child: Container(
                      width: 120.0,
                      height: 120.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.amberAccent, width: 4.0),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            'https://cdn.antaranews.com/cache/1200x800/2023/05/23/gibran-24.jpg',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 70.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildProfileField('Name', nameController),
                    buildProfileField('NIM', nimController),
                    buildProfileField('Email', emailController),
                    buildProfileField('Status', statusController),
                    buildProfileField('Birth Date', birthDateController),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Colors.amberAccent,
              fontFamily: 'RobotoMono',
            ),
          ),
          const SizedBox(height: 4.0),
          isEditing
              ? TextField(
                  controller: controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.amberAccent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 40, 44, 52),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  ),
                )
              : Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 40, 44, 52),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.amberAccent, width: 1.5),
                  ),
                  child: Text(
                    controller.text,
                    style: const TextStyle(fontSize: 16.0, color: Colors.white, fontFamily: 'RobotoMono'),
                  ),
                ),
        ],
      ),
    );
  }
}
