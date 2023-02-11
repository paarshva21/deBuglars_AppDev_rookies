import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unscript_rookies_app/Display.dart';
import 'package:unscript_rookies_app/Finances.dart';
import 'package:unscript_rookies_app/Inventory.dart';
import 'package:unscript_rookies_app/UserPage.dart';

class ProviderDisplay extends StatefulWidget {
  String? Email;
  String? PhoneNo;
  String? Password;
  bool? Verified;
  String? uid;
  ProviderDisplay(
      {Key? key,
      required this.Email,
      required this.PhoneNo,
      required this.Password,
      required this.Verified,
      required this.uid})
      : super(key: key);

  @override
  State<ProviderDisplay> createState() => _ProviderDisplayState();
}

class _ProviderDisplayState extends State<ProviderDisplay> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Provider Dashboard"),
        backgroundColor: Colors.green,
      ),
      drawer: NavigationDrawer(),
      body: widget.Verified!
          ? VerifiedProvider()
          : Center(
              child: Container(
                padding: EdgeInsets.all(30),
                child: Text(
                    "Your request for being approved as Provider is currently being reviewed by the Admin. "
                    "Thank you for your patience!"),
              ),
            ),
    ));
  }
}

class VerifiedProvider extends StatefulWidget {
  const VerifiedProvider({Key? key}) : super(key: key);

  @override
  State<VerifiedProvider> createState() => _VerifiedProviderState();
}

class _VerifiedProviderState extends State<VerifiedProvider> {
  List<Widget> screens = [Finances(), Inventory(), Display()];
  int currentIndex = 0;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedFontSize: 18,
        unselectedFontSize: 14,
        iconSize: 27,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.attach_money,
              color: Colors.white,
            ),
            label: "Finances",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              Icons.inventory,
              color: Colors.white,
            ),
            label: "Inventory",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.display_settings,
              color: Colors.white,
            ),
            label: "Display",
          ),
        ],
      ),
      body: screens[currentIndex],
    ));
  }
}
