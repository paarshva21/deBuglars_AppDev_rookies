import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:unscript_rookies_app/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unscript_rookies_app/Utils.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String email1 = "", password1 = "", password2 = "";

  bool hidden1 = true;
  bool hidden2 = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/blacked.jpg"),
                  fit: BoxFit.cover,
                  opacity: 0.5),
            ),
            child: SafeArea(
              child: Center(
                child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: GestureDetector(
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        child: SingleChildScrollView(
                            child: Center(
                          child: Column(children: [
                            SizedBox(
                              width: 20.0,
                              height: 30.0,
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 300.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.arrow_back_sharp),
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(50.0)),
                            Container(
                              padding: EdgeInsets.only(top: 15),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(20.0)),
                            Container(
                                padding:
                                    EdgeInsets.only(left: 35.0, right: 35.0),
                                child: Column(children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(13),
                                        fillColor: Colors.white,
                                        filled: true,
                                        hintText: "Enter Email",
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey),
                                        errorStyle: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w500),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                            borderSide: BorderSide.none)),
                                    controller: emailController,
                                    validator: (email) {
                                      if (email != null &&
                                          !EmailValidator.validate(email)) {
                                        return 'Please enter a Valid Email';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      email1 = value!;
                                    },
                                  ),
                                  Padding(padding: EdgeInsets.all(10.0)),
                                  TextFormField(
                                    obscureText: hidden1,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: "Enter Password",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                      errorStyle: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500),
                                      suffix: InkWell(
                                          onTap: () {
                                            setState(() {
                                              hidden1 = !hidden1;
                                            });
                                          },
                                          child: Icon(
                                            !hidden1
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            size: 20,
                                          )),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          borderSide: BorderSide.none),
                                    ),
                                    controller: passwordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter Password';
                                      } else if (value.length < 6) {
                                        return "Enter minimum six characters";
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      password1 = value!;
                                    },
                                  ),
                                  Padding(padding: EdgeInsets.all(10.0)),
                                  TextFormField(
                                    obscureText: hidden2,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: "Confirm Password",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                      errorStyle: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500),
                                      suffix: InkWell(
                                          onTap: () {
                                            setState(() {
                                              hidden2 = !hidden2;
                                            });
                                          },
                                          child: Icon(
                                            !hidden2
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            size: 20,
                                          )),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          borderSide: BorderSide.none),
                                    ),
                                    onSaved: (value) {
                                      password2 = value!;
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please confirm password';
                                      }
                                      if (password1 != password2) {
                                        return "Password doesn't match Confirm Password";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                    height: 50.0,
                                  ),
                                  Container(
                                      width: 135.0,
                                      height: 40.0,
                                      color: Colors.green,
                                      child: TextButton(
                                        onPressed: () {
                                          _formKey.currentState!.save();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            if (password1 == password2) {
                                              EmailSignUp();
                                            }
                                          }
                                        },
                                        child: Text(
                                          "Sign Up",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                ]))
                          ]),
                        )))),
              ),
            )));
  }

  Future EmailSignUp() async {
    try {
      var user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim()))
          .user;
      await FirebaseFirestore.instance
          .collection('App Users')
          .doc(user?.uid)
          .set({
        "Email": email1,
        "Password": password1,
        "Verified": false,
        "PhoneNo": "0",
        "uid": user?.uid
      });
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
  }
}
