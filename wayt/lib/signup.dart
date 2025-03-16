import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/enhanced_new_image_2.png', // Ensure this image exists in assets
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color.fromARGB(255, 0, 0, 0),
                        size: 24, // Smaller back button
                      ),
                    ),
                    Text(
                      'JOURNEY',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 2, 22, 53),
                        fontFamily: 'Poppins', // Keep Poppins for "JOURNEY"
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Image.asset(
                  'assets/signup_image.png', // Replace with the correct image filename
                  width: 320, // Increased image size
                  height: 220, // Increased image size
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 320, // Match the width of the image
                  child: Center(
                    child: Text(
                      'ADVENTURE AWAITS',
                      style: TextStyle(
                        fontSize: 24, // Bigger font size
                        color: Colors.black, // Changed to black
                        fontWeight: FontWeight.bold, // Bold text
                        fontFamily: 'Homenaje', // Homenaje font
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextField('Full Name'),
                const SizedBox(height: 8), // Reduced spacing
                _buildTextField('Email or Phone Number'),
                const SizedBox(height: 8), // Reduced spacing
                _buildTextField('Username'),
                const SizedBox(height: 8), // Reduced spacing
                _buildPasswordField('Password'),
                const SizedBox(height: 8), // Reduced spacing
                _buildPasswordField('Confirm Password'),
                const SizedBox(height: 20),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 1, 25, 60),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins', // Keep Poppins for other text
                        fontSize: 14, // Smaller font size
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Have an account? Log In',
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Poppins', // Keep Poppins for other text
                      fontSize: 14, // Smaller font size
                    ),
                  ),
                ),
                const Spacer(),
                const Center(
                  child: Text(
                    'We need permission for the service you use',
                    style: TextStyle(
                      color: Colors.black, // Changed to black
                      fontFamily: 'Poppins', // Keep Poppins for other text
                      fontSize: 14, // Smaller font size
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Learn More',
                    style: TextStyle(
                      color: Colors.black, // Changed to black
                      fontFamily: 'Poppins', // Keep Poppins for other text
                      fontSize: 14, // Smaller font size
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label) {
    return SizedBox(
      width: 280,
      height: 40, // Smaller text box
      child: TextField(
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Poppins', // Keep Poppins for text boxes
          fontSize: 14, // Smaller font size
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.white70,
            fontFamily: 'Poppins', // Keep Poppins for text boxes
            fontSize: 14, // Smaller font size
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 1, 25, 60),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0), // Rounder corners
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label) {
    return SizedBox(
      width: 280,
      height: 40, // Smaller text box
      child: TextField(
        obscureText: _obscurePassword,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Poppins', // Keep Poppins for text boxes
          fontSize: 14, // Smaller font size
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.white70,
            fontFamily: 'Poppins', // Keep Poppins for text boxes
            fontSize: 14, // Smaller font size
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 1, 25, 60),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0), // Rounder corners
            borderSide: BorderSide.none,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility : Icons.visibility_off,
              color: Colors.white70,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
        ),
      ),
    );
  }
}
