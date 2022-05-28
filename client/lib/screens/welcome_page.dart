import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:camera/camera.dart';
import 'package:gmap/screens/Check_inPage.dart';
import 'package:gmap/screens/Check_outPage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(30, 30, 0, 3),
                          child: const Text(
                            "WelCome",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      data == null ? "" : data!['fname'].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset('assets/welcomeimage.png'),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 3),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckInPage(),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 50,
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(15),
                            primary: Colors.blue.shade800,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckOutPage(),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.outbond_sharp,
                            size: 50,
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue.shade800,
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Important Announcements...",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                      style: TextStyle(color: Colors.black),
                    )
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
