import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
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
        title: Text(
          "Provider Dashboard",
          style: TextStyle(color: Colors.black87),

        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined)),
        ],
        backgroundColor: Colors.redAccent,
      ),
      drawer: NavigationDrawer(),
      body: widget.Verified!
          ? VerifiedProvider()
          : Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Lottie.network(
                        'https://assets2.lottiefiles.com/private_files/lf30_t6juv2mp.json',
                        height: 200)),
                SizedBox(
                  height: 180,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Your request for being approved as Provider is currently being reviewed by the Admin. "
                    "Thank you for your patience!",
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ],
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
        backgroundColor: Colors.redAccent,
        selectedItemColor: Colors.black,
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
            ),
            label: "Analytics",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              Icons.inventory,
            ),
            label: "Inventory",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.display_settings,
            ),
            label: "Display",
          ),
        ],
      ),
      body: screens[currentIndex],
    ));
  }
}
