import 'package:flutter/material.dart';
import 'package:unscript_rookies_app/UserPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.green,
      ),
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
                return Center(child: (Text("Error occured!1")));
              } else {
                return Center(child: (Text("Error occured2!")));
              }
            } catch (e) {
              print(e.toString());
              return Center(child: (Text("Error occured!3")));
            }
          }),
    );
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