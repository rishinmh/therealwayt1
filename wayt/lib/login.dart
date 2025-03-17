import 'package:flutter/material.dart';
import 'package:wayt/waythomepage.dart';
import 'signup.dart'; // Import the signup page

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = false; // State for the "Remember Me" checkbox
  bool _obscurePassword = true; // State for password visibility
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    // Simple authentication check
    if (username == "admin" && password == "admin") {
      // Navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid username or password"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/login_page.png', // Ensure this image exists in assets
              fit: BoxFit.cover,
            ),
          ),

          // Bottom Section (Blue Box)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: const BoxDecoration(
                color: Color(0xFF0A2A50), // Match the blue shade in the image
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "I'M WAITING FOR YOUR JOURNEY",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    "Username, Email or Phone Number",
                    controller: _usernameController,
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    "Password",
                    isPassword: true,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 10),
                  _buildCheckbox(),
                  const SizedBox(height: 10),
                  _buildLoginButton(context),
                  const SizedBox(height: 10),
                  _buildRegisterOption(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Text Field
  Widget _buildTextField(
    String hint, {
    bool isPassword = false,
    TextEditingController? controller,
  }) {
    return SizedBox(
      height: 40, // Even smaller text box
      child: TextField(
        controller: controller,
        obscureText: isPassword && _obscurePassword,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white70,
            fontSize: 12, // Smaller font size
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none, // Remove border
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2), // Slight transparency
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          suffixIcon:
              isPassword
                  ? IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white70,
                      size: 20, // Smaller icon
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  )
                  : null,
        ),
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  // Remember Me Checkbox
  Widget _buildCheckbox() {
    return SizedBox(
      height: 30, // Shorter row
      child: Row(
        children: [
          Checkbox(
            value: _rememberMe,
            onChanged: (value) {
              setState(() {
                _rememberMe = value ?? false;
              });
            },
            activeColor: Colors.white,
            checkColor: Colors.blue,
            materialTapTargetSize:
                MaterialTapTargetSize.shrinkWrap, // Smaller checkbox
          ),
          const Text(
            "Remember Me",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Forgot Password?",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Login Button
  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3, // 1/3 of the screen width
      child: ElevatedButton(
        onPressed: () => _login(context), // Call login function
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10),
          backgroundColor: Colors.white.withOpacity(0.9),
          foregroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          "Log In",
          style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
        ),
      ),
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
        style: TextStyle(
          fontFamily: 'Poppins',
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}
