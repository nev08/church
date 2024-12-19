import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'user_payments.dart';
import 'admin_dash.dart';
import 'dart:typed_data';
import 'view_user.dart';
import 'add_user.dart';
import 'common.dart';

class UserProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserProfileScreen(),
    );
  }
}

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  List<Map<String, dynamic>> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final response = await http.post(Uri.parse('http://192.168.1.9:80/church/fewdetail.php'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        setState(() {
          users = List<Map<String, dynamic>>.from(data['users']);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onMenuOptionSelected(String option, String userId, String name) {
    if (option == 'View Payments') {
      // Navigate to the PaymentPage with userId and name
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ContributionScreen(userId: userId, name: name),
        ),
      );
    } else if (option == 'Terminate') {
      // Handle "Terminate"
      print("Terminate clicked");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF760643),
              Color(0xFF882055),
              Color(0xFFFFFFFF),
            ],
            stops: [0.0, 0.35, 0.95],
          ),
        ),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
          children: [
            SizedBox(height: 50),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChurchPayApp(),
                      ),
                    ); // This will navigate back to the previous page
                  },
                ),
                Spacer(),
                Text(
                  'USER PROFILES',
                  style: GoogleFonts.juliusSansOne(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                Spacer(flex: 2),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search user',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,  // Define the itemCount to avoid RangeError
                itemBuilder: (context, index) {
                  String base64Image = users[index]['img'];
                  Uint8List? decodedBytes;
                  if (base64Image != null && base64Image.isNotEmpty) {
                    decodedBytes = base64Decode(base64Image);
                  }
                  String userId = users[index]['user_id'];
                  String name = users[index]['Name'];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0), // Add space between cards
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      color: Color(0XFFFDCFCF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        onTap: () {
                          // Navigate to ProfilePage with the clicked user details
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(userId: userId),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          backgroundImage: decodedBytes != null
                              ? MemoryImage(decodedBytes)
                              : AssetImage('assets/default.png') as ImageProvider,
                          radius: 28,
                        ),
                        title: Text(
                          '  USER ' + userId,
                          style: GoogleFonts.juliusSansOne(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        subtitle: Text(
                          '   ' + name,
                          style: GoogleFonts.juliusSansOne(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        trailing: PopupMenuButton<String>(
                          onSelected: (String option) {
                            _onMenuOptionSelected(option, userId, name);
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem<String>(
                                value: 'View Payments',
                                child: Text('View Payments'),
                              ),
                              PopupMenuItem<String>(
                                value: 'Terminate',
                                child: Text('Terminate'),
                              ),
                            ];
                          },
                          icon: Icon(Icons.more_vert), // Three-dot menu icon
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateProfileApp()),
          );
        },
        backgroundColor: Color(0xFF760643),
        child: Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }
}
