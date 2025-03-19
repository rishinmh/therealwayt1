import 'package:flutter/material.dart';
import 'login.dart'; // Import the login page
import 'explore.dart'; // Import the explore page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wayt App',
      theme: ThemeData(
        fontFamily:
            'Poppins', // Ensures Poppins font is used throughout the app
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(), // Set LoginPage as the main page
    );
  }
}
