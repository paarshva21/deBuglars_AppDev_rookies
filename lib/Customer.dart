import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unscript_rookies_app/UserHome.dart';
import 'package:unscript_rookies_app/UserLoc.dart';
import 'package:unscript_rookies_app/UserPage.dart';

class Customer extends StatefulWidget {
  const Customer({Key? key}) : super(key: key);

  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {

  final _currentUser = FirebaseAuth.instance.currentUser!;
  int _currentIndex = 0;
  final screens = [
    UserHome(),
    UserLoc()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            icon: Icon(Icons.home),
            label: 'Home',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Location',
          ),
        ],
      ),
      body: screens[_currentIndex],
      drawer: NavigationDrawer(),
    );
  }
}

class Food {
  int? id;
  String? name;
  String? date;
  String? price;
  String? quantity;
  int? provider;

  Food(
      {this.id,
        this.name,
        this.date,
        this.price,
        this.quantity,
        this.provider});

  Food.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    date = json['date'];
    price = json['price'];
    quantity = json['quantity'];
    provider = json['provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['date'] = this.date;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['provider'] = this.provider;
    return data;
  }
}


Future<List<Food>> getData(String? email) async {
  List<Food> list = [];
  String url = "http://192.168.29.59:8021/food_userview/";
  http.Response response = await http.get(Uri.parse(url));
  print(response.body);
  try {
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var rest = data as List;
      print(rest);
      list = rest.map<Food>((json) => Food.fromJson(json)).toList();
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print(e.toString());
  }
  return list;
}