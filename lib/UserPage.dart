import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unscript_rookies_app/HomePage.dart';
import 'package:unscript_rookies_app/Setting.dart';
import 'package:unscript_rookies_app/Utils.dart';
import 'package:unscript_rookies_app/ProviderDisplay.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final user = FirebaseAuth.instance.currentUser!;
  String? Email;
  String? PhoneNo;
  String? Password;
  bool? Verified;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: NavigationDrawer(),
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
                  if (snapshot.data?.Password == "adminpass" &&
                      snapshot.data?.Email == "aryatel26@gmail.com") {
                    return Text("Admin");
                  }
                  else if (snapshot.data?.PhoneNo == "0") {
                    return Text("Customer");
                  } else
                    return ProviderDisplay(
                      Email: snapshot.data?.Email,
                      PhoneNo: snapshot.data?.PhoneNo,
                      Password: snapshot.data?.Password,
                      Verified: true,
                      uid:snapshot.data?.uid
                    );
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
  final String uid;

  AppUser(
      {required this.Email,
      required this.Password,
      required this.Verified,
      required this.PhoneNo,
        required this.uid});

  Map<String, dynamic> toJson() => {
        'Email': Email,
        'Verified': Verified,
        'Password': Password,
        'PhoneNo': PhoneNo,
         'uid': uid
      };

  static AppUser fromJson(Map<String, dynamic> json) => AppUser(
      Email: json["Email"],
      Verified: json["Verified"],
      PhoneNo: json["PhoneNo"],
      Password: json["Password"],
      uid: json["uid"]);
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
