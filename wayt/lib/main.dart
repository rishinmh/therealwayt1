import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wayt/waythomepage.dart';
import 'firebase_options.dart';
import 'login.dart';
import 'explore.dart';
import 'booking_selector.dart';
// Make sure you have a HomePage imported

Future<void> main() async {
  const env = String.fromEnvironment('ENV', defaultValue: 'dev');
  await dotenv.load(fileName: '.env.$env');
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthWrapper(), // Use auth wrapper instead of direct login
      routes: {
        '/home': (context) => const HomePage(),
        '/explore': (context) => const ExplorePage(),
        '/booking': (context) => BookingSelectorPage(),
      },
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  late Future<User?> _authCheckFuture;

  @override
  void initState() {
    super.initState();
    _authCheckFuture = _checkAuthState();
  }

  Future<User?> _checkAuthState() async {
    // Wait for Firebase Auth to initialize and check current user
    await Future.delayed(const Duration(milliseconds: 300)); // Optional delay
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _authCheckFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading screen while checking auth state
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Check if user exists
        final user = snapshot.data;
        if (user != null) {
          // User is logged in, redirect to home page
          return const HomePage();
        } else {
          // User is not logged in, show login page
          return const LoginPage();
        }
      },
    );
  }
}