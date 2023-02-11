import 'package:flutter/material.dart';
import 'package:unscript_rookies_app/UserPage.dart';
import 'ProvidersPage.dart';
import 'UsersPage.dart';
import 'AdminHome.dart';

class AdminDash extends StatefulWidget {
  const AdminDash({Key? key}) : super(key: key);
  @override
  State<AdminDash> createState() => _AdminDashState();
}

List<String> adminList = ["Arya Telang"];
List<String> adminEmail = ["aryatel26@gmail.com"];
List<String> adminPass = ["adminpass"];
List screens = [ProvidersPage(), AdminHome(), UsersPage()];
int _currentIndex = 0;

class _AdminDashState extends State<AdminDash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard"),
        backgroundColor: Colors.green,
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedFontSize: 18,
        unselectedFontSize: 14,
        iconSize: 27,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Providers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility_sharp),
            label: 'Users',
          ),
        ],
      ),
      drawer: NavigationDrawer(),
    );
  }
}
