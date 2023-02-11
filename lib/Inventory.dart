import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Inventory extends StatefulWidget {
  const Inventory({Key? key}) : super(key: key);

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  var user = FirebaseAuth.instance.currentUser!;
  final TextEditingController _FoodName = TextEditingController();
  final TextEditingController _Quantity = TextEditingController();
  final TextEditingController _Price = TextEditingController();
  String quantity="";
  String foodName="";
  String price="";
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              width: 20.0,
              height: 30.0,
            ),
            Text(
              "Enter food details",
              style: TextStyle(
                color: Colors.green,
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              width: 20.0,
              height: 30.0,
            ),
            TextFormField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(13),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Food Item",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                  errorStyle:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      borderSide: BorderSide.none)),
              controller: _FoodName,
              onSaved: (value) {
                foodName = value!;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value?.length == 0) return "Enter Food Item";
                return null;
              },
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                fillColor: Colors.white,
                filled: true,
                hintText: "Quantity",
                hintStyle:
                    TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
                errorStyle:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    borderSide: BorderSide.none),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value?.length == 0) return "Enter quantity";
                return null;
              },
              controller: _Quantity,
              onSaved: (value) {
                quantity = value!;
              },
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                fillColor: Colors.white,
                filled: true,
                hintText: "Price Per Item",
                hintStyle:
                    TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
                errorStyle:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    borderSide: BorderSide.none),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value?.length == 0) return "Enter price";
                return null;
              },
              controller: _Price,
              onSaved: (value) {
                price = value!;
              },
            ),
            SizedBox(
              width: 20.0,
              height: 30.0,
            ),
            Container(
                width: 135.0,
                height: 40.0,
                color: Colors.green,
                child: TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      foodName = _FoodName.text.trim();
                      price = _Price.text.trim();
                      quantity = _Quantity.text.trim();
                      addData(foodName, user.email, price, quantity);
                    }
                  },
                  child: Text(
                    "Enter",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                )),
            SizedBox(
              width: 20.0,
              height: 20.0,
            ),
          ]),
        ),
      ),
    );
  }
}

void addData(String? foodName, String? email, String? price, String? quantity) {
  print(foodName);
  print(price);
  print(quantity);
  print(email);
  http.post(
    Uri.parse('http://192.168.29.59:8000/add_food/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "name": foodName!,
      "provider": email!,
      "price": price!,
      "quantity": quantity!
    }),
  );
}

