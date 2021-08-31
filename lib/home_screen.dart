import 'package:flutter/material.dart';
import 'package:skitoboxes/models/box.dart';
import 'package:skitoboxes/views/bottom_navbar/dashboard_pageview/dashboard_body.dart';
import 'package:skitoboxes/views/bottom_navbar/dashboard_pageview/dashboard_screen.dart';
import 'package:skitoboxes/views/bottom_navbar/profile_screen.dart';
import 'package:skitoboxes/views/bottom_navbar/subscription_screen.dart';
import 'package:skitoboxes/views/bottom_navbar/wishlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> bottomScreens = [
    DashboardBody(),
    WishlistScreen(),
    SubscriptionScreen(),
    ProfileScreen(),
  ];

  int _selectedScreen = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: bottomScreens.elementAt(_selectedScreen),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        currentIndex: _selectedScreen,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.subscriptions_outlined,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: '',
          ),
        ],
      ),
    );
  }
}
