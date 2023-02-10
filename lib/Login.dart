import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:unscript_rookies_app/ForgotPassword.dart';
import 'package:unscript_rookies_app/SignUp.dart';
import 'package:unscript_rookies_app/SignUpProvider.dart';
import 'Utils.dart';

import 'UserPage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String email = "", password = "";
  bool hidden = true;

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: SafeArea(
            child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Scaffold(
            backgroundColor: Colors.black,
            body: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: SingleChildScrollView(
                child: Column(children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(top: 120.0),
                      child: Text(
                        "App",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 50.0,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(40.0)),
                  Container(
                    padding: EdgeInsets.only(left: 35.0, right: 35.0),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(13),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Email",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                              errorStyle: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide.none)),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (email) {
                            if (email != null &&
                                !EmailValidator.validate(email)) {
                              return 'Please enter a Valid Email';
                            }
                            return null;
                          },
                          controller: _emailController,
                          onSaved: (value) {
                            email = value!;
                          },
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        TextFormField(
                          obscureText: hidden,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Password",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                            errorStyle: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w500),
                            suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  hidden = !hidden;
                                });
                              },
                              child: Icon(
                                !hidden
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 20,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide: BorderSide.none),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Password';
                            } else if (value.length < 6) {
                              return "Enter minimum six characters";
                            }
                            return null;
                          },
                          controller: _passwordController,
                          onSaved: (value) {
                            password = value!;
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
                                  EmailLogIn();
                                }
                              },
                              child: Text(
                                "Login",
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
                        GestureDetector(
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.white,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ForgotPassWord()));
                          },
                        ),
                        SizedBox(
                          width: 20.0,
                          height: 50.0,
                        ),
                        RichText(
                          text: TextSpan(
                              text:
                                  "Haven't yet made an account? Click here to ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                              ),
                              children: [
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignUp()));
                                      },
                                    text: "Sign Up.",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.green))
                              ]),
                        ),
                        SizedBox(
                          width: 20.0,
                          height: 30.0,
                        ),
                        RichText(
                          text: TextSpan(
                              text:
                              "Looking to contribute? Click here to ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                              ),
                              children: [
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignUpProvider()));
                                      },
                                    text: "Provide.",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.green))
                              ]),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        )));
  }

  Future EmailLogIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => UserPage()));
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
  }
}
