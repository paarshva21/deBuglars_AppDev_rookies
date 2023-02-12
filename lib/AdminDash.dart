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

      backgroundColor: Color(0xFFEDE5D8),
      appBar: AppBar(
        title: Text("Admin Dashboard"),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined)),
        ],
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.redAccent,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedFontSize: 18,
        unselectedFontSize: 14,
        iconSize: 27,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Providers',
            backgroundColor: Colors.redAccent,
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
