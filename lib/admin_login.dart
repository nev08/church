import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'admin_dash.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF760643), // Dark Red wine
              Color(0xFF882055), // Lighter Red
              Color(0xFFFFFFFF), // Very Light Red/Pink
              Color(0xFFFFFFFF), // White
            ],
            stops: [
              0.0, // Dark red wine starts
              0.35, // Lighter red in the middle
              0.95, // Very light red/pink towards the bottom
              1.0, // White at the bottom
            ],
          ),
        ),
        child: Center(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 38),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            elevation: 10,
            color: const Color(0xFFF9E0E0),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Add image above the login text
                  Image.asset(
                    'assets/login.png', // Path to your image
                    width: 100, // Adjust width and height accordingly
                    height: 100,
                  ),
                  const SizedBox(height: 25), // Space between the image and text

                  // Login text
                  Text(
                    'Login ',
                    style: GoogleFonts.juliusSansOne(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20), // Space between the login text and username field

                  // Username field
                  _buildTextField(
                    labelText: 'Username',
                    prefixIcon: Icons.person_outline,
                  ),
                  const SizedBox(height: 15),

                  // Password field
                  _buildTextField(
                    labelText: 'Password',
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),

                  // Login button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  ChurchPayApp()),
                      );// Add login logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF760643), // Dark Red wine background color
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 10,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Reusable _buildTextField method
  Widget _buildTextField({
    required String labelText,
    required IconData prefixIcon,
    bool obscureText = false,
  }) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFFDCFCF), // Light pink color for textfields
        labelText: labelText,
        labelStyle: GoogleFonts.juliusSansOne(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
        prefixIcon: Icon(prefixIcon, color: Colors.black54),
        suffixIcon: obscureText
            ? const Icon(Icons.visibility_off, color: Colors.black54)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
