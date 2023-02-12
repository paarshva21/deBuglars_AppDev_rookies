import 'package:flutter/material.dart';

class Finances extends StatefulWidget {
  const Finances({Key? key}) : super(key: key);

  @override
  State<Finances> createState() => _FinancesState();
}

class _FinancesState extends State<Finances> {

  List TimeList = ["Weekly","Monthly","Annually"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDE5D8),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50,horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 40,
                width: 50,
              ),
              DropdownButtonFormField(
                items: TimeList.map((e) {
                  return DropdownMenuItem(
                    child: Text(
                      e,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                    value: e,
                  );
                }).toList(),
                value: TimeList[0],
                onChanged: (val) {},
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(13),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(7.0),
                        borderSide: BorderSide.none)),
                onSaved: (value) {
                },
              ),
              Padding(padding: EdgeInsets.all(10)),
              Image.asset("assets/download.png",
              width: 345,
              height: 360,
              fit: BoxFit.fill,),
              Padding(padding: EdgeInsets.all(10)),
              Text("Number of donations in specified time period")
            ],
          ),
        ),
      ),
    );
  }
}
