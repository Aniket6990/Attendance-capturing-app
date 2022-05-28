import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmap/bloc/welcome_bloc.dart';
import 'package:gmap/screens/history.dart';
import 'package:gmap/screens/profilepage.dart';
import 'package:gmap/screens/welcome_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreens() {
    return [
      BlocProvider(
        create: (context) => WelcomeBloc(),
        child: WelcomePage(),
      ),
      const History(),
      const ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Colors.blue.shade800,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.history),
        title: ("History"),
        activeColorPrimary: Colors.blue.shade800,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Profile"),
        activeColorPrimary: Colors.blue.shade800,
        inactiveColorPrimary: Colors.black,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}
