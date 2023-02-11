import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Inventory extends StatefulWidget {
  const Inventory({Key? key}) : super(key: key);

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(45),
        child: ElevatedButton(
          onPressed: getData,
          child: Container(
          ),
        ),
      ),
    );
  }
}

void getData() async{
  String url =
      "http://192.168.29.59:8000/view_food/";
  http.Response response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  print(data[0]["id"]);
  log(data.toString());
}
