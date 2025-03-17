import 'package:flutter/material.dart';
import 'signup.dart'; // Import the signup page

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/login_page.png', // Make sure this image is in your assets folder
              fit: BoxFit.cover,
            ),
          ),
          // Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "HEY!\nWELCOME",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "I'M WAITING FOR YOUR JOURNEY",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField("Username, Email or Phone Number"),
                const SizedBox(height: 10),
                _buildTextField("Password", isPassword: true),
                const SizedBox(height: 10),
                _buildCheckbox(),
                const SizedBox(height: 10),
                _buildLoginButton(),
                const SizedBox(height: 20),
                _buildRegisterOption(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Text Field
  Widget _buildTextField(String hint, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontFamily: 'Poppins'),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white.withOpacity(0.9),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        ),
      ),
    );
  }

  // Remember Me Checkbox
  Widget _buildCheckbox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Checkbox(value: false, onChanged: (value) {}),
          const Text("Remember Me", style: TextStyle(fontFamily: 'Poppins')),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Forgot Password?",
              style: TextStyle(fontFamily: 'Poppins'),
            ),
          ),
        ],
      ),
    );
  }

  // Login Button
  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
        backgroundColor: Colors.white.withOpacity(0.9),
        foregroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text("Log In", style: TextStyle(fontFamily: 'Poppins')),
    );
  }

  // Register Option
  Widget _buildRegisterOption(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignupPage()),
        );
      },
      child: const Text(
        "Don't have an account? Register",
        style: TextStyle(fontFamily: 'Poppins'),
      ),
    );
  }
}
