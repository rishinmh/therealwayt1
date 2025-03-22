import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wayt/waythomepage.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = false;
  bool _obscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/login_page.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: const BoxDecoration(
                color: Color(0xFF0A2A50),
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
                    "Email",
                    controller: _emailController,
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

  Widget _buildTextField(String hint, {
    bool isPassword = false,
    TextEditingController? controller,
  }) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: controller,
        obscureText: isPassword && _obscurePassword,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white70,
            fontSize: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility : Icons.visibility_off,
              color: Colors.white70,
              size: 20,
            ),
            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
          )
              : null,
        ),
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  Widget _buildCheckbox() {
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          Checkbox(
            value: _rememberMe,
            onChanged: (value) => setState(() => _rememberMe = value ?? false),
            activeColor: Colors.white,
            checkColor: Colors.blue,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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

  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: ElevatedButton(
        onPressed: () async {
          try {
            await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } on FirebaseAuthException catch (e) {
            String errorMessage = 'Login failed. Please try again.';
            if (e.code == 'user-not-found') {
              errorMessage = 'No user found with that email.';
            } else if (e.code == 'wrong-password') {
              errorMessage = 'Wrong password provided.';
            } else if (e.code == 'invalid-email') {
              errorMessage = 'Invalid email format.';
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error occurred: $e'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
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

  Widget _buildRegisterOption(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignupPage()),
      ),
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