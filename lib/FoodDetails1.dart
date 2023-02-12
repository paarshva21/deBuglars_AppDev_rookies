import 'package:flutter/material.dart';

class FoodDetails1 extends StatefulWidget {
  FoodDetails1({Key? key}) : super(key: key);

  @override
  State<FoodDetails1> createState() => _FoodDetails1State();
}

class _FoodDetails1State extends State<FoodDetails1> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDE5D8),
      appBar: AppBar(
        title: Text(
          "Food Details",
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 60,
                  ),
                  Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/tameta.jpg"),
                      radius: 100,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(20)),
                  Text("Date of expiry is 23/2/2023"),
                  Padding(padding: EdgeInsets.all(10)),
                  Text("Name of provider is Rajesh Restaurants"),
                  Padding(padding: EdgeInsets.all(10)),
                  Text("Quantity of tomatoes is 3 kg"),
                  Padding(padding: EdgeInsets.all(10)),
                  Text("Price of unit quantity is Rs 20"),
                  Padding(padding: EdgeInsets.all(10)),
                ]),
          ),
        ),
      ),
    );
  }
}
