import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'common.dart';
import 'userprofiles.dart';

class CreateProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreateProfilePage(),
    );
  }
}

class CreateProfilePage extends StatefulWidget {
  @override
  _CreateProfilePageState createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _sectorController = TextEditingController();
  final TextEditingController _zoneController = TextEditingController();
  final TextEditingController _familyGroupController = TextEditingController();
  final TextEditingController _maritalStatusController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  File? _image;
  final picker = ImagePicker();
  String? _newUserId; // Variable to store the new user ID

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _fetchLastUserId() async {
    final response = await http.get(Uri.parse("http://192.168.1.9:80/church/get_last_user_id.php"));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      String lastUserId = responseData['lastUserId'];

      // Extract the numeric part of the user ID (after the 'D')
      String prefix = lastUserId.substring(0, 1); // Extract 'D'
      String numericPart = lastUserId.substring(1); // Extract numeric part like '1001'

      // Increment the numeric part
      int lastIdNumber = int.parse(numericPart);
      String newUserId = prefix + (lastIdNumber + 1).toString().padLeft(4, '0');
      print(newUserId); // e.g., D1002

      // Update the state with the new user ID
      setState(() {
        _newUserId = newUserId;
      });
    } else {
      throw Exception('Failed to fetch last user ID');
    }
  }


  Future<void> _saveProfile() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select an image')));
      return;
    }

    String base64Image = base64Encode(_image!.readAsBytesSync());

    // Ensure the user ID is fetched before saving the profile
    if (_newUserId == null) {
      await _fetchLastUserId();
    }

    Map<String, dynamic> postData = {
      'user_id': _newUserId, // Use the generated user_id here
      'Name': _nameController.text,
      'Age': _ageController.text,
      'DOB': _dobController.text,
      'Gender': _genderController.text,
      'Zone': _zoneController.text,
      'Fgl': _familyGroupController.text,
      'Sector': _sectorController.text,
      'Marital_status': _maritalStatusController.text,
      'Phn': _contactNoController.text,
      'Password': _passwordController.text,
      'img': base64Image,
    };

    final response = await http.post(
      Uri.parse(add_user),
      headers: {"Content-Type": "application/json"},
      body: json.encode(postData),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile saved successfully')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${responseData['message']}')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save profile')));
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch the last user ID when the page is initialized
    _fetchLastUserId();
  }

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileApp(),
                        ),
                      );  // This will navigate back to the previous page
                    },
                  ),
                  Spacer(),
                  Text(
                    'ADD USER',
                    style:  GoogleFonts.juliusSansOne(
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
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? Icon(Icons.person_add_alt_1, size: 40, color: Colors.black)
                            : null,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      _newUserId != null
                          ? 'USERNAME: $_newUserId'
                          : 'Fetching User ID...', // Display the user ID here
                      style: GoogleFonts.juliusSansOne(
                        fontSize: 18,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    _buildTextField('Name', controller: _nameController),
                    _buildTextField('DOB', controller: _dobController, icon: Icons.calendar_today),
                    Row(
                      children: [
                        Expanded(child: _buildTextField('Gender', controller: _genderController)),
                        SizedBox(width: 16),
                        Expanded(child: _buildTextField('Age', controller: _ageController)),
                      ],
                    ),
                    _buildTextField('Sector', controller: _sectorController),
                    _buildTextField('Zone', controller: _zoneController),
                    _buildTextField('Family Group', controller: _familyGroupController),
                    _buildTextField('Marital Status', controller: _maritalStatusController),
                    _buildTextField('Contact No', controller: _contactNoController),
                    _buildTextField('Password', controller: _passwordController, obscureText: true),
                  ],
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF760643),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  ),
                  child: Text(
                    'SAVE',
                    style: GoogleFonts.juliusSansOne(
                        fontSize: 18,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {TextEditingController? controller, IconData? icon, bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: icon != null ? Icon(icon) : null,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

