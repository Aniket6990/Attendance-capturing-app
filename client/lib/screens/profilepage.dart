import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final storage = new FlutterSecureStorage();
  Map? data;
  Future ProfileApiCall() async {
    String? token = await storage.read(key: "token");
    http.Response response;
    response = await http.get(
      Uri.parse("http://10.0.2.2:4000/api/profile/"),
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
    data = jsonDecode(response.body);
    setState(() {});
  }

  @override
  void initState() {
    ProfileApiCall();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Info:",
                  style: TextStyle(
                      color: Colors.blue.shade800,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "First Name: ${data == null ? "" : data?['fname']}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Last Name: ${data == null ? "" : data?['lname']}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Registration Number: ${data == null ? "" : data?['registrationNumber']}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Email id: ${data == null ? "" : data?['email']}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Date of Birth: ${data == null ? "" : data?['dob']}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Gender: ${data == null ? "" : data?['gender']}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Joining year: ${data == null ? "" : data?['joiningYear']}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Contact Number: ${data == null ? "" : data?['contactNumber']}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
