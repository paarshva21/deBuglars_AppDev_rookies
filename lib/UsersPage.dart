import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDE5D8),
      body: StreamBuilder<List<AppUser>>(
        stream: readUsers(),
        builder: (context, snapshot) {
          log(snapshot.data.toString());
          if (snapshot.hasData) {
            List<AppUser> arrVerified = [];
            List<AppUser> arrUnverified = [];
            int i, c1 = 0, c2 = 0;
            for (i = 0; i < snapshot.data!.length; i++) {
              if (snapshot.data![i].PhoneNo == "0" &&
                  !snapshot.data![i].Verified &&
                  snapshot.data![i].Password != "adminpass") {
                arrUnverified.add(snapshot.data![i]);
                c1++;
              }
            }
            for (i = 0; i < snapshot.data!.length; i++) {
              if (snapshot.data![i].PhoneNo == "0" &&
                  !snapshot.data![i].Verified &&
                  snapshot.data![i].Password != "adminpass") {
                arrVerified.add(snapshot.data![i]);
                c2++;
              }
            }
            return Column(children: [
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "Users",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return buildUser1(
                        arrVerified[index], arrVerified[index].Verified);
                  },
                  itemCount: c2,
                  shrinkWrap: true,
                ),
              ),
            ]);
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return const Text('Something went wrong');
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
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
    return null;
  }

  Widget buildUser1(AppUser? user, bool Verified) => ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(Icons.account_circle, color: Colors.black),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${user?.Email}'),
          ],
        ),
      );

  Stream<List<AppUser>> readUsers() => FirebaseFirestore.instance
      .collection('App Users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => AppUser.fromJson(doc.data())).toList());

  void update(String? uid) async {
    await FirebaseFirestore.instance
        .collection('App Users')
        .doc(uid)
        .update({"Verified": true});
  }

  void updateData(String? email) {
    http.post(
      Uri.parse('http://192.168.29.59:8000/add_provider/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "email": "$email",
        "is_admin": "False",
        "is_provider": "True",
        "is_user": "True"
      }),
    );
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
        'uid': uid,
      };

  static AppUser fromJson(Map<String, dynamic> json) => AppUser(
      Email: json["Email"],
      Verified: json["Verified"],
      PhoneNo: json["PhoneNo"],
      Password: json["Password"],
      uid: json["uid"]);
}
