import 'package:flutter/material.dart';

class FoodDetails extends StatefulWidget {
  FoodDetails({Key? key}) : super(key: key);

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  final feedbackController = TextEditingController();
  String feedback = "";
  final formKey = GlobalKey<FormState>();

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
            child: Form(
              key: formKey,
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
                    if (feedback != "")
                      Text(
                        "Review :$feedback",
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    Padding(padding: EdgeInsets.all(10)),
                    TextFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(13),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Enter feedback",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                          errorStyle: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w500),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              borderSide: BorderSide.none)),
                      controller: feedbackController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (feedback == null) {
                          return "No feedback entered";
                        }
                      },
                      onSaved: (value) {
                        feedback = value!;
                      },
                      maxLines: 10,
                      minLines: 1,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Center(
                      child: SizedBox(
                          height: 30,
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  feedback = feedbackController.text.trim();
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFEC4C47),
                              foregroundColor: Colors.black,
                            ),
                            child: const Text("Enter"),
                          )),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
