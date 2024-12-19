import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '2ndpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Churchpay',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App logo placeholder (increased size)
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/logo.png', // Path to your image
                    width: 180, // Adjust width and height accordingly
                    height: 170,
                    //fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 100), // Adjusted distance between logo and button

              GestureDetector(
                onTap: () {
                  // Navigate to the login screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminUserSelectionPage()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    'Churchpay',
                    style: GoogleFonts.tillana(
                      textStyle: TextStyle(
                        fontSize: 30, // Adjust the size as needed
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4B0000), // Red wine text color
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100), // Adjusted distance between button and quote

              // Scripture text
              const Text(
                '“ God loves a cheerful giver ”',
                style: TextStyle(
                  fontFamily: 'Cursive',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
