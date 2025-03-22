import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wayt/waythomepage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _obscurePassword = true;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/enhanced_new_image_2.png',
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
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Color.fromARGB(255, 0, 0, 0),
                    size: 24,
                  ),
                ),
                const Text(
                  'JOURNEY',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 2, 22, 53),
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Image.asset(
              'assets/signup_image.png',
              width: 320,
              height: 220,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 320,
              child: const Center(
                child: Text(
                  'ADVENTURE AWAITS',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Homenaje',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildTextField('Full Name', _fullNameController),
            const SizedBox(height: 8),
            _buildTextField('Email', _emailController),
            const SizedBox(height: 8),
            _buildTextField('Username', _usernameController),
            const SizedBox(height: 8),
            _buildPasswordField('Password', _passwordController),
            const SizedBox(height: 8),
            _buildPasswordField('Confirm Password', _confirmPasswordController),
            const SizedBox(height: 20),
            SizedBox(width: 150,),
              ElevatedButton(
                onPressed: () async {
                  if (_validateFields()) {
                    await _signUpUser();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 1, 25, 60),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 14,
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
                    fontFamily: 'Poppins',
                    fontSize: 14,
                  ),
                ),
              ),
              const Spacer(),
              const Center(
                child: Text(
                  'We need permission for the service you use',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Learn More',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 14,
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

  Widget _buildTextField(String label, TextEditingController controller) {
    return SizedBox(
      width: 280,
      height: 40,
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Poppins',
          fontSize: 14,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.white70,
            fontFamily: 'Poppins',
            fontSize: 14,
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 1, 25, 60),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return SizedBox(
      width: 280,
      height: 40,
      child: TextField(
        controller: controller,
        obscureText: _obscurePassword,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Poppins',
          fontSize: 14,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.white70,
            fontFamily: 'Poppins',
            fontSize: 14,
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 1, 25, 60),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility : Icons.visibility_off,
              color: Colors.white70,
            ),
            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
          ),
        ),
      ),
    );
  }

  bool _validateFields() {
    if (_fullNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _usernameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return false;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return false;
    }

    return true;
  }

  Future<void> _signUpUser() async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await _storeUserDetails(
        user: userCredential.user!,
        fullName: _fullNameController.text.trim(),
        email: _emailController.text.trim(),
        username: _usernameController.text.trim(),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Sign up failed. Please try again.';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred: $e')),
      );
    }
  }

  Future<void> _storeUserDetails({
    required User user,
    required String fullName,
    required String email,
    required String username,
  }) async {
    try {
      final db = FirebaseFirestore.instance;
      final userRef = db.collection('Users').doc(user.uid);

      await userRef.set({
        'uid': user.uid,
        'fullName': fullName,
        'email': email,
        'username': username,
        'gSign': false,
        'status': 'Approved',
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error storing user details: $e');
      rethrow;
    }
  }
}
