import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unscript_rookies_app/HomePage.dart';
import 'package:unscript_rookies_app/Screen1.dart';
import 'package:unscript_rookies_app/Screen2.dart';
import 'package:unscript_rookies_app/Screen3.dart';
import 'package:unscript_rookies_app/Setting.dart';
import 'package:unscript_rookies_app/Utils.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int currentIndex = 0;
  final user = FirebaseAuth.instance.currentUser!;
  final screens = [Screen1(), Screen2(), Screen3()];

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
                Icons.fastfood,
                color: Colors.white,
              ),
              label: "Recipes",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(
                Icons.icecream,
                color: Colors.white,
              ),
              label: "Desserts",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              label: "Favourites",
            ),
          ],
        ),
        drawer: NavigationDrawer(),
        appBar: AppBar(
          title: Text("Boilerplate"),
          backgroundColor: Colors.green,
        ),
        body: FutureBuilder<AppUser?>(
            future: readUser(),
            builder: (context, snapshot) {
              try {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error occured!"),
                  );
                } else if (snapshot.hasData) {
                  if (snapshot.data?.PhoneNo == "0") {
                    return Text("Customer");
                  } else
                    return Text("Provider");
                } else {
                  return Center(
                    child: Text("Error occured!"),
                  );
                }
              } catch (e) {
                print(e.toString());
                return Center(
                  child: Text("Error occured!"),
                );
              }
            }),
      ),
    );
  }

  Future<AppUser?> readUser() async {
    var doc = await FirebaseFirestore.instance
        .collection("App Users")
        .doc(user.uid)
        .get();
    if (doc.exists) {
      print(doc);
      return AppUser.fromJson(doc.data()!);
    }
  }
}

class AppUser {
  final String Email;
  final String Password;
  final bool Verified;
  final String PhoneNo;

  AppUser(
      {required this.Email,
      required this.Password,
      required this.Verified,
      required this.PhoneNo});

  Map<String, dynamic> toJson() => {
        'Email': Email,
        'Verified': Verified,
        'Password': Password,
        'PhoneNo': PhoneNo
      };

  static AppUser fromJson(Map<String, dynamic> json) => AppUser(
      Email: json["Email"],
      Verified: json["Verified"],
      PhoneNo: json["PhoneNo"],
      Password: json["Password"]);
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[buildHeader(context), buildMenuItems(context)],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(top: 20.0),
      );

  Widget buildMenuItems(BuildContext context) => Container(
      padding: EdgeInsets.all(24.0),
      child: Wrap(runSpacing: 16, children: [
        Column(children: <Widget>[
          ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.green,
                size: 30,
              ),
              title: Text(
                "Profile",
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
              onTap: () {}),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Colors.green,
              size: 30,
            ),
            title: Text("About Us",
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w700,
                    fontSize: 20)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.green,
              size: 30,
            ),
            title: Text("Settings",
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w700,
                    fontSize: 20)),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Setting()));
            },
          ),
          Divider(
            color: Colors.green,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.green,
              size: 30,
            ),
            title: Text("Logout",
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w700,
                    fontSize: 20)),
            onTap: () {
              try {
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomePage()),
                  ModalRoute.withName('/'),
                );
              } on FirebaseAuthException catch (e) {
                print(e.message);
                Utils.showSnackBar(e.message);
              }
            },
          ),
        ]),
      ]));
}
