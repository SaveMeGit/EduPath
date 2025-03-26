// import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: theme.primaryColor,
//               child: Text("S", style: TextStyle(color: Colors.white)),
//             ),
//             SizedBox(width: 10),
//             Text("Home", style: theme.textTheme.titleLarge),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.all(16),
//               children: [
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: ChatBubble(text: "Hi Sarah! How can I help you with Math today?", isSender: false, time: "10:30 AM"),
//                 ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: ChatBubble(text: "I need help understanding quadratic equations.", isSender: true, time: "10:31 AM"),
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: ChatBubble(text: "Sure! A quadratic equation is in the form ax² + bx + c = 0, where a ≠ 0.", isSender: false, time: "10:32 AM"),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: "Type a message...",
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send, color: theme.primaryColor),
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 DropdownButton<String>(
//                   value: "Math",
//                   items: ["Math", "Science", "English"].map((String subject) {
//                     return DropdownMenuItem<String>(
//                       value: subject,
//                       child: Text("Subject: $subject"),
//                     );
//                   }).toList(),
//                   onChanged: (value) {},
//                 ),
//                 DropdownButton<String>(
//                   value: "EN",
//                   items: ["EN", "AR", "FR", "ES"].map((String lang) {
//                     return DropdownMenuItem<String>(
//                       value: lang,
//                       child: Text("Language: $lang"),
//                     );
//                   }).toList(),
//                   onChanged: (value) {},
//                 ),
//               ],
//             ),
//           ),
//           BottomNavigationBar(
//             items: [
//               BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//               BottomNavigationBarItem(icon: Icon(Icons.school), label: "Homeschool"),
//               BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ChatBubble extends StatelessWidget {
//   final String text;
//   final bool isSender;
//   final String time;

//   const ChatBubble({super.key, required this.text, required this.isSender, required this.time});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: EdgeInsets.all(12),
//           margin: EdgeInsets.symmetric(vertical: 5),
//           decoration: BoxDecoration(
//             color: isSender ? Colors.blue[400] : Colors.grey[200],
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Text(text, style: TextStyle(color: isSender ? Colors.white : Colors.black)),
//         ),
//         Padding(
//           padding: EdgeInsets.only(left: 8, right: 8),
//           child: Text(time, style: TextStyle(fontSize: 12, color: Colors.grey)),
//         ),
//       ],
//     );
//   }
// }

















import 'package:flutter/material.dart';
import 'package:flutter_edu_path/screens/home_school_screen.dart';
import 'package:flutter_edu_path/screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const HomeschoolScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "Homeschool"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _chatMessages = [];
  String _selectedSubject = "Math";
  String _selectedLanguage = "EN";

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _chatMessages.add({
        "text": _messageController.text.trim(),
        "isSender": true,
        "time": _formatTime(),
      });

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _chatMessages.add({
            "text": "I'm just a test bot for now, Original! coming soon.",
            "isSender": false,
            "time": _formatTime(),
          });
        });
      });
    });

    _messageController.clear();
  }

  String _formatTime() {
    final now = TimeOfDay.now();
    return "${now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.period == DayPeriod.am ? 'AM' : 'PM'}";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,  // This removes the back button

        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: theme.primaryColor,
              child: const Text("S", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(width: 10),
            Text("Home", style: theme.textTheme.titleLarge),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                final message = _chatMessages[index];
                return Align(
                  alignment: message["isSender"] ? Alignment.centerRight : Alignment.centerLeft,
                  child: ChatBubble(
                    text: message["text"],
                    isSender: message["isSender"],
                    time: message["time"],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: theme.primaryColor),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDropdown("Subject", ["Math", "Science", "English"], _selectedSubject, (value) {
                  setState(() {
                    _selectedSubject = value!;
                  });
                }),
                _buildDropdown("Language", ["EN", "AR", "FR", "ES"], _selectedLanguage, (value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> options, String value, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text("$label: $option"),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSender;
  final String time;

  const ChatBubble({super.key, required this.text, required this.isSender, required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: isSender ? Colors.blue[400] : Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(text, style: TextStyle(color: isSender ? Colors.white : Colors.black)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ),
      ],
    );
  }
}
