import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'common.dart';

class ProfilePage extends StatefulWidget {
  final String userId;
  ProfilePage({required this.userId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? userDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    final url = Uri.parse("http://192.168.1.9:80/church/profile_display.php");
    try {
      final response = await http.post(url, body: {
        'user_id': widget.userId,
      });

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == true) {
          setState(() {
            userDetails = jsonResponse['userDetails'];
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          print(jsonResponse['message']);
        }
      } else {
        setState(() {
          isLoading = false;
        });
        print('Server Error');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching user details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF760643),
        appBar: AppBar(
          backgroundColor: Color(0xFF760643),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          title: Text(
            'PROFILE ',
            style: GoogleFonts.juliusSansOne(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          centerTitle: true,

        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : userDetails != null
            ? Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              //colors: [Color(0xFF4B013B), Color(0xFFE3A6B8)],
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
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Back card
                Positioned(
                  top: 120,
                  left: 20,
                  right: 20,
                  bottom: 90,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Color(0xFFFFB6C1),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileField(
                            label: 'NAME               ',
                            value: userDetails!['Name'],
                          ),
                          ProfileField(
                            label: 'DOB                 ',
                            value: userDetails!['DOB'].toString(),
                          ),
                          ProfileField(
                            label: 'AGE                  ',
                            value: userDetails!['Age'].toString(),
                          ),
                          ProfileField(
                            label: 'GENDER            ',
                            value: userDetails!['Gender'],
                          ),
                          ProfileField(
                            label: 'SECTOR             ',
                            value: userDetails!['Sector'],
                          ),
                          ProfileField(
                            label: 'ZONE                ',
                            value: userDetails!['Zone'],
                          ),
                          ProfileField(
                            label: 'FAMILY GROUP   ',
                            value: userDetails!['Fgl'],
                          ),
                          ProfileField(
                            label: 'MARITAL STATUS  ',
                            value: userDetails!['Marital_status'],
                          ),
                          ProfileField(
                            label: 'CONTACT NO     ',
                            value: userDetails!['Phn'].toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Image placeholder
                Positioned(
                  top: 50,
                  left: MediaQuery.of(context).size.width / 2 - 70,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.black,
                    child: ClipOval(
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: userDetails?['img'] != null &&
                            (userDetails?['img'] as String)
                                .isNotEmpty
                            ? Image.network(
                          '$ip/${userDetails?['img']}',
                          fit: BoxFit.cover,
                        )
                            : Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
            : Center(
          child: Text(
            'No user details available',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class ProfileField extends StatelessWidget {
  final String label;
  final String value;

  ProfileField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: GoogleFonts.juliusSansOne(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}