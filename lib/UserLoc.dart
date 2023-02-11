import 'package:flutter/material.dart';
import 'package:unscript_rookies_app/UserPage.dart';

class UserLoc extends StatefulWidget {
  const UserLoc({Key? key}) : super(key: key);

  @override
  State<UserLoc> createState() => _UserLocState();
}

class _UserLocState extends State<UserLoc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
        backgroundColor: Colors.green,
      ),
      drawer: NavigationDrawer(),
    );
  }
}
