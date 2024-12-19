import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';


class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

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
              0.0,   // Dark red wine starts
              0.35,   // Lighter red in the middle
              0.95,   // Very light red/pink towards the bottom
              1.0,   // White at the bottom
            ],
          ),
        ),
        child: Center(
          child: Container(
            width: 350, // Adjust the width for better alignment
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF9E0E0), // Light pink container
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),

                // User icon
                Image.asset(
                  'assets/login.png', // Path to your image
                  width: 100, // Adjust width and height accordingly
                  height: 100,
                ),

                const SizedBox(height: 20),

                // Sign In Text
                Text(
                  'SIGN IN',
                  style: GoogleFonts.juliusSansOne(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 20),

                // Username TextField
                _buildTextField(
                  labelText: 'USERNAME',
                  prefixIcon: Icons.person_outline,
                ),
                const SizedBox(height: 15),

                // New Password TextField
                _buildTextField(
                  labelText: 'NEW PASSWORD',
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                ),
                const SizedBox(height: 15),

                // Confirm Password TextField
                _buildTextField(
                  labelText: 'CONFIRM PASSWORD',
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                ),
                const SizedBox(height: 25),

                // Register button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ULoginPage()),
                    );// Add your logic for register button here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF760643), // Light pink color for button
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white , fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required IconData prefixIcon,
    bool obscureText = false,
  }) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFFFDCFCF), // Light pink color for textfields
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


