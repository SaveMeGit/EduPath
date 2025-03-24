import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Settings")
        ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey,
                          child: Text("T", style: TextStyle(fontSize: 24, color: Colors.white)),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.add, size: 14, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ms. Johnson",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text("teacher@example.com", style: TextStyle(color: Colors.grey)),
                        Text("Account Type: Teacher", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Edit Profile Button
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Edit Profile"),
              ),
            ),

            const SizedBox(height: 30),

            // Your Students Section
            const Text(
              "Your Students",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            _buildStudentTile("S", "Sarah Adams", "Grade: 9"),
            _buildStudentTile("J", "James Wilson", "Grade: 9"),
            _buildStudentTile("E", "Emily Chen", "Grade: 9"),

            const SizedBox(height: 20),

            // Add Student Button
            Center(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("+ Add Student"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentTile(String initial, String name, String grade) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[300],
        child: Text(initial, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(grade, style: const TextStyle(color: Colors.grey)),
    );
  }
}
