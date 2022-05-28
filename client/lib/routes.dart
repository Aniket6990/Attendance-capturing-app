import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmap/screens/Check_inPage.dart';
import 'package:gmap/bloc/login_bloc.dart';
import 'package:gmap/screens/login_page.dart';
import 'package:gmap/screens/main_page.dart';
import 'package:gmap/bloc/welcome_bloc.dart';
import 'package:gmap/screens/welcome_page.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginBloc(),
            child: const LoginPage(),
          ),
        );
      case "/first":
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => WelcomeBloc(),
            child: const MainPage(),
          ),
        );
      case "/checkin":
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => WelcomeBloc(),
            child: const CheckInPage(),
          ),
        );

      default:
        {
          return null;
        }
    }
  }
}
