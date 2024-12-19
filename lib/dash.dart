import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'contribute.dart';
import 'profile.dart';
import 'my_reciepts.dart';
import 'razorpay.dart';
import 'Phonepepayment.dart';
import 'gpayconsole.dart';

class ChurchPayHome extends StatelessWidget {
  final String user_id;
  ChurchPayHome({required this.user_id});
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
              0.35,  // Lighter red in the middle
              0.95,  // Very light red/pink towards the bottom
              1.0,   // White at the bottom
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Icon and Title
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0 , horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start, // Centers the content horizontally
                  children: [
                    // Profile Circle Avatar as a button
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  ProfilePage(userId: user_id)),
                        );
                        print("Profile button tapped!");
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xFFFDCFCF), // Profile circle icon
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 50), // Spacing between the avatar and the text

                    // CHURCH PAY Text
                    Text(
                      'CHURCH PAY',
                      style: GoogleFonts.juliusSansOne(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),

              // Greeting Card aligned left
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 20.0, top: 30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, top: 10),
                        width: 320, // Adjust as per requirement
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.pink.shade200, // Darker shadow card
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Container(
                        width: 320, // Same width for both cards
                        height: 150,
                        decoration: BoxDecoration(
                          color: Color(0xFFFDCFCF), // Light pink card
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Hi User !',
                              style: GoogleFonts.juliusSansOne(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 50),

              // Contribution Button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentPage()),
                  );
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xFFFDCFCF), // Icon background color
                      child: Icon(
                        Icons.volunteer_activism,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Contribute',
                      style: GoogleFonts.juliusSansOne(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30), // Space between buttons

              // View Receipts Button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => myreciepts( userId: user_id,)),
                  );// Define the action for "View Receipts"
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xFFFDCFCF), // Icon background color
                      child: Icon(
                        Icons.receipt_long,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'View Receipts',
                      style: GoogleFonts.juliusSansOne(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
