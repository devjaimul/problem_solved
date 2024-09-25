import 'package:flutter/material.dart';

class CustomnavScreen extends StatefulWidget {
  const CustomnavScreen({super.key});

  @override
  State<CustomnavScreen> createState() => _CustomnavScreenState();
}

class _CustomnavScreenState extends State<CustomnavScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       /*Center( // Add a body here
        child: Text('Welcome to the Home Screen'),
      ),*/
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // Set to white or a lighter color
        selectedItemColor: Colors.teal, // Color for the selected item
        unselectedItemColor: Colors.black54, // Color for unselected items
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Browse'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Store'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Order History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
