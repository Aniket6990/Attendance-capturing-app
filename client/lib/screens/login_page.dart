import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gmap/Apihandler.dart';
import 'package:gmap/bloc/login_bloc.dart';
import 'package:gmap/bloc/login_event.dart';
import 'package:gmap/bloc/login_state.dart';
import 'package:gmap/screens/main_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final storage = new FlutterSecureStorage();

  TextEditingController emailController = TextEditingController();
  ApiHandler apiHandler = ApiHandler();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool circular = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: emailController,
                onChanged: (val) {
                  BlocProvider.of<LoginBloc>(context).add(
                      LoginTextFieldChangeEvent(
                          userIdValue: emailController.text,
                          passwordValue: passwordController.text));
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    FontAwesomeIcons.userPlus,
                    color: Colors.black,
                  ),
                  hintText: "User id",
                  hintStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: passwordController,
                onChanged: (val) {
                  BlocProvider.of<LoginBloc>(context).add(
                      LoginTextFieldChangeEvent(
                          userIdValue: emailController.text,
                          passwordValue: passwordController.text));
                },
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    FontAwesomeIcons.lock,
                    color: Colors.black,
                  ),
                  hintText: "Password",
                  hintStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoginErrorState) {
                    return Text(
                      state.errorMessage,
                      style: const TextStyle(color: Colors.red),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoginValidState) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue[800],
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(14)),
                      child: circular
                          ? const SpinKitFoldingCube(
                              color: Colors.white,
                              size: 30,
                            )
                          : const Icon(
                              FontAwesomeIcons.arrowRight,
                              size: 40, //Icon Size
                              color: Colors.white,
                              //Color Of Icon
                            ),
                      onPressed: () async {
                        setState(() {
                          circular = true;
                        });
                        Map<String, String> data = {
                          "registrationNumber": emailController.text,
                          "password": passwordController.text,
                        };
                        var response =
                            await apiHandler.post("/api/login/", data);
                        if (response.statusCode == 200 ||
                            response.statusCode == 201) {
                          Map<String, dynamic> output =
                              json.decode(response.body);
                          print(output["token"]);
                          await storage.write(
                              key: "token", value: output["token"]);

                          setState(() {
                            circular = false;
                          });

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainPage(),
                              ),
                              (route) => false);
                        } else {
                          dynamic output = json.decode(response.body);
                          setState(() {
                            circular = false;
                          });
                          // ignore: deprecated_member_use
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "${output['message']}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red.shade300,
                            action: SnackBarAction(
                                label: 'UNDO',
                                textColor: Colors.blue.shade800,
                                // ignore: deprecated_member_use
                                onPressed: () {
                                  // ignore: deprecated_member_use
                                  Scaffold.of(context).removeCurrentSnackBar(
                                      reason: SnackBarClosedReason.remove);
                                }),
                          ));
                        }
                      },
                    );
                  } else {
                    return ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: Colors.grey[800],
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(14)),
                      child: const Icon(
                        FontAwesomeIcons.arrowRight,
                        size: 40, //Icon Size
                        color: Colors.white,
                        //Color Of Icon
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
