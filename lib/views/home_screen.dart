import 'package:flutter/material.dart';
import 'package:polynotepad/views/add_screen.dart';
import 'package:polynotepad/views/profile_screen.dart';

import '../global widgets/customlist.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int myIndex = 0;

  // Create a GlobalKey to access the CustomlistState
  final GlobalKey<CustomlistState> customListKey = GlobalKey<CustomlistState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Note Pad"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) async {
          if (index == 1) { // If Add Note screen is selected
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddNoteScreen()),
            );
            if (result == true) {
              // Switch back to Home and refresh the list
              setState(() {
                myIndex = 0;
              });
              customListKey.currentState?.readDatabase(); // Call readDatabase to refresh
            }
          } else {
            setState(() {
              myIndex = index;
            });
          }
        },
        currentIndex: myIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: IndexedStack(
        index: myIndex,
        children: [
          Customlist(key: customListKey), // Use GlobalKey to refer to CustomlistState
          const SizedBox.shrink(), // Placeholder for AddNoteScreen
          const Profile_page(), // Profile screen
        ],
      ),
    );
  }
}
