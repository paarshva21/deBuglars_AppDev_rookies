import 'package:flutter/material.dart';
import 'package:unscript_rookies_app/FoodDetails.dart';
import 'package:unscript_rookies_app/UserPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDE5D8),
      drawer: NavigationDrawer(),
      body: FutureBuilder<List<dynamic>>(
          future: getData(),
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
                return Center(child: (Text("Error occured!")));
              } else {
                return Center(child: (Text("Error occured!")));
              }
            } catch (e) {
              print(e.toString());
              return Center(child: (Text("Error occured!")));
            }
          }),
    );
  }

  Widget buildFood(Food food) {
    return ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.fastfood, color: Colors.black),
        ),
        subtitle: Text(food.quantity!),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              food.name!,
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        trailing: Text('Rs. ' + food.price!),
        onTap: () {
          if (food.name != null) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FoodDetails(
                    )));
          }
        });
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

Future<List<Food>> getData() async {
  List<Food> list = [];
  String url = "http://192.168.29.59:8000/food_userview/";
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
