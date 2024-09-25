import 'package:flutter/material.dart';
import 'dart:async';

import 'home_screen.dart'; // For creating a delay

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delayed transition to next screen (e.g., Home screen)
    Timer(const Duration(seconds: 3), () {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.lightBlueAccent, // Background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.note, // Notepad icon
              size: 100,
              color: Colors.white,
            ),
            SizedBox(height: 20), // Space between icon and text
            Text(
              "Notepad",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10), // Space between app name and tagline
            Text(
              "Capture your thoughts",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
