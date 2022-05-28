import 'package:flutter/material.dart';
import 'package:gmap/routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String page = "/";
  final storage = const FlutterSecureStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CheckLoggedinorNot();
  }

  void CheckLoggedinorNot() async {
    String? token = await storage.read(key: "token");
    if (token != null) {
      setState(() {
        page = '/first';
      });
    } else {
      setState(() {
        page = '/';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gmap',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Routes.onGenerateRoute,
      initialRoute: page,
      debugShowCheckedModeBanner: false,
    );
  }
}
