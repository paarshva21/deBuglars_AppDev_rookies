import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Display extends StatefulWidget {
  const Display({Key? key}) : super(key: key);

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  var user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: getData(user.email),
        builder: (context, snapshot) {
          try {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return buildFood(snapshot.data![index]);
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: (Text("Error occured!1")));
            } else {
              return Center(child: (Text("Error occured2!")));
            }
          } catch (e) {
            print(e.toString());
            return Center(child: (Text("Error occured!3")));
          }
        });
  }

  Widget buildFood(Food food) {
    return ListTile(
      title: Text(food.name!),
      trailing: Text(food.price!),
      subtitle: Text(food.quantity!),
    );
  }
}

class Food {
  late final int id;
  late final String name;
  late final String date;
  late final String price;
  late final String quantity;
  late final int provider;

  Food(
      {required this.id,
        required this.name,
        required this.date,
        required this.price,
        required this.quantity,
        required this.provider});

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
  String url = "http://192.168.29.59:8000/view_food/$email";
  http.Response response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  print(data[0]["id"]);
  log(data.toString());
  headers:
  jsonEncode(<String, String>{
    "provider": email!,
  });
  return data;
}
