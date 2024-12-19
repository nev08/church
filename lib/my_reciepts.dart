import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class myreciepts extends StatelessWidget {
  final String userId;
  //final String name;

  myreciepts({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF760643),
              Color(0xFF882055),
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF),
            ],
            stops: [0.0, 0.35, 0.95, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      child: Text(
                        'My Reciepts',
                        style: GoogleFonts.juliusSansOne(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Color(0xFFFDCFCF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'USER: $userId',
                        style: GoogleFonts.juliusSansOne(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Search Bar Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFFDCFCF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search by amount, date',
                            hintStyle: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ),
                      Icon(Icons.search, color: Colors.black54),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeader(title: 'November 2024'),
                        SizedBox(height: 12),
                        ContributionCard(
                          to: 'Indian Church of Christ',
                          purpose: 'Monthly Contribution',
                          amount: '₹ 2000',
                          paymentMethod: 'Google Pay',
                          date: 'November 21',
                        ),
                        SizedBox(height: 16),
                        ContributionCard(
                          to: 'Indian Church of Christ',
                          purpose: 'Special Contribution',
                          amount: '₹ 1000',
                          paymentMethod: 'Phone Pay',
                          date: 'November 18',
                        ),
                        SizedBox(height: 30),
                        SectionHeader(title: 'October 2024'),
                        SizedBox(height: 12),
                        ContributionCard(
                          to: 'Indian Church of Christ',
                          purpose: 'General Contribution',
                          amount: '₹ 1500',
                          paymentMethod: 'Google Pay',
                          date: 'October 10',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
      //width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF930853), // Background color matching the image
      ),
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.juliusSansOne(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white, // White text
            letterSpacing: 2.0, // Matching the image's style
          ),
        ),
      ),
    );
  }
}

class ContributionCard extends StatelessWidget {
  final String to;
  final String purpose;
  final String amount;
  final String paymentMethod;
  final String date;

  ContributionCard({
    required this.to,
    required this.purpose,
    required this.amount,
    required this.paymentMethod,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFDCFCF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TO: $to',
            style: GoogleFonts.juliusSansOne(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'FOR: $purpose',
            style: GoogleFonts.juliusSansOne(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                amount,
                style: GoogleFonts.juliusSansOne(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                paymentMethod,
                style: GoogleFonts.juliusSansOne(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            date,
            style: GoogleFonts.juliusSansOne(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}