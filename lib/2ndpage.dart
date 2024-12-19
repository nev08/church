import 'package:flutter/material.dart';
import 'dart:math';
import 'admin_login.dart';
import 'login.dart';

class AdminUserSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF760643), // Dark Red wine
                Color(0xFF882055), // Lighter Red
                Color(0xFFFFFFFF), // Very Light Red/Pink
                Color(0xFFFFFFFF), // White
              ],
              stops: [0.0, 0.35, 0.95, 1.0],
            ),
          ),
          child: Center(
            child: Container(
              width: 300,
              height: 400,
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Color(0xFFF9E0E0),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildCustomOption(
                      context, 'ADMIN', Icons.admin_panel_settings, LoginPage()),
                  SizedBox(height: 50),
                  _buildCustomOption(
                      context, 'USER', Icons.person, ULoginPage()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomOption(
      BuildContext context, String label, IconData icon, Widget targetPage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      },
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(
                  icon,
                  size: 50,
                  color: Color(0xFF7A0138),
                ),
              ),
              Positioned.fill(
                child: CustomPaint(
                  painter: CutoutCirclePainter(),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF7A0138),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class CutoutCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF7A0138)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    final path = Path();
    path.addArc(
        Rect.fromCircle(center: Offset(size.width/2, size.height/2), radius: 50),
        pi / 4,
        4 * pi );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
