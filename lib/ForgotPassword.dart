import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unscript_rookies_app/Utils.dart';

class ForgotPassWord extends StatefulWidget {
  const ForgotPassWord({Key? key}) : super(key: key);

  @override
  State<ForgotPassWord> createState() => _ForgotPassWordState();
}

class _ForgotPassWordState extends State<ForgotPassWord> {
  final formKey = GlobalKey<FormState>();

  String email = "";

  final TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
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
                                Container(
                                  padding: EdgeInsets.only(top: 230),
                                  child: Text(
                                    "Reset password via email.",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(20.0)),
                                Container(
                                  padding: EdgeInsets.only(left: 35.0, right: 35.0),
                                  child: TextFormField(
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
                                            borderRadius: BorderRadius.circular(7.0),
                                            borderSide: BorderSide.none)),
                                    validator: (email) {
                                      if (email != null &&
                                          !EmailValidator.validate(email)) {
                                        return 'Please enter a Valid Email';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      email = value!;
                                    },
                                    controller: emailController,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(20.0)),
                                Container(
                                    width: 135.0,
                                    height: 40.0,
                                    color: Colors.green,
                                    child: TextButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          resetPassword();
                                        }
                                      },
                                      child: Text(
                                        "Send email",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                              ]),
                            )))),
              )),
        ));
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Utils.showSnackBar("Email sent to " + emailController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
  }
}