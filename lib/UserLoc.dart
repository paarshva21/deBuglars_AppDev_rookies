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

      backgroundColor: Color(0xFFEDE5D8),
      appBar: AppBar(
        title: Text("Location",style: TextStyle(color: Colors.black87),),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined)),
        ],
      ),
      drawer: NavigationDrawer(),
    );
  }
}
