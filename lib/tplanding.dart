import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:unscript_rookies_app/UserPage.dart';

class TpLanding extends StatefulWidget {
  const TpLanding({Key? key}) : super(key: key);

  @override
  State<TpLanding> createState() => _TpLandingState();
}

class _TpLandingState extends State<TpLanding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Aboard"),
        backgroundColor: Colors.green,

      ),
      body: Column(
        children: [
          Align(
              alignment: Alignment.center,
              child: Lottie.network(
                'https://assets6.lottiefiles.com/packages/lf20_ysas4vcp.json',
              )),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => UserPage()));
            },
            child: Text(
              "Next ",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}