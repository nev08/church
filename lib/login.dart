import 'dart:convert'; // For jsonEncode
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http; // For making HTTP requests
import 'sign_in.dart';
import 'dash.dart';

class ULoginPage extends StatelessWidget {
  const ULoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController user_idController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF760643),
              Color(0xFF882055),
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF),
            ],
            stops: [0.0, 0.35, 0.95, 1.0],
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
                  Image.asset(
                    'assets/login.png',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'Login',
                    style: GoogleFonts.juliusSansOne(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: user_idController,
                    labelText: 'User id',
                    prefixIcon: Icons.person_outline,
                  ),
                  const SizedBox(height: 15),
                  _buildTextField(
                    controller: passwordController,
                    labelText: 'Password',
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      String user_id = user_idController.text;
                      String password = passwordController.text;

                      // Send login request
                      var response = await login(user_id, password);

                      if (response['status'] == 'success') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChurchPayHome(user_id: user_id)),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(response['message'])),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF760643),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 10,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 15),
                  Text.rich(
                    TextSpan(
                      text: 'New? ',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Register',
                          style: const TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignInPage()),
                              );
                            },
                        ),
                      ],
                    ),
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
    required TextEditingController controller,
    required String labelText,
    required IconData prefixIcon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFFDCFCF),
        labelText: labelText,
        labelStyle: GoogleFonts.juliusSansOne(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
        prefixIcon: Icon(prefixIcon, color: Colors.black54),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Login method to send data to PHP server
  Future<Map<String, dynamic>> login(String user_id, String password) async {
    var url = Uri.parse('http://192.168.1.14/church/login.php');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': user_id,
        'Password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Returns the response from PHP (status and message)
    } else {
      return {'status': 'failure', 'message': 'Server error'};
    }
  }
}
