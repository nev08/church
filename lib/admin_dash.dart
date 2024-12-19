import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'userprofiles.dart';

class ChurchPayApp extends StatelessWidget {
  const ChurchPayApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChurchPayScreen(),
    );
  }
}

class ChurchPayScreen extends StatelessWidget {
  const ChurchPayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF720046), // Top dark pink
              Color(0xFFF5CEDD), // Bottom light pink
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),
            // Top Bar with Title and Menu Icon
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Icon(Icons.menu, color: Colors.white, size: 24),
                  const Spacer(),
                  Text(
                    "CHURCH PAY",
                    style: GoogleFonts.juliusSansOne(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Hanging Nail
            Center(
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Main Hanging Card
            Container(
              width: 300,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Color(0XFFFDCFCF),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserProfileApp()),
                      );/// Handle USER PROFILE button press
                    },
                    child: _buildSection("USER PROFILE", "assets/user.jpg", imageSize: 80),
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color(0xFFFFFFFF),
                    indent: 40,
                    endIndent: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle PAYMENTS button press
                    },
                    child: _buildSection("PAYMENTS", "assets/payments.jpg", imageSize: 80),
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color(0xFFFFFFFF),
                    indent: 40,
                    endIndent: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle PRINT RECEIPTS button press
                    },
                    child: _buildSection("PRINT RECEIPTS", "assets/reciepts.jpg", imageSize: 80),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String imagePath, {double imageSize = 80}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          // Circle with Image
          Container(
            width: imageSize, // Adjust the width based on imageSize parameter
            height: imageSize, // Adjust the height based on imageSize parameter
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(imagePath), // Local image path
                //fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Text
          Text(
            title,
            style: GoogleFonts.juliusSansOne(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF000000),
            ),
          ),
        ],
      ),
    );
  }
}
