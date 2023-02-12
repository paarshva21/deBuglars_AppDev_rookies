import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:unscript_rookies_app/UserPage.dart';

class tplanding extends StatefulWidget {
  const tplanding({Key? key}) : super(key: key);

  @override
  State<tplanding> createState() => _tplandingState();
}

class _tplandingState extends State<tplanding> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Welcome Aboard"),
          backgroundColor: Colors.redAccent,

        ),
        body: Container(
          decoration: BoxDecoration(color: Color(0xFFEDE5D8),),
          child: Column(
            children: [

              Align(
                  alignment: Alignment.center,
                  child: Lottie.network(
                    'https://assets5.lottiefiles.com/packages/lf20_6yhhrbk6.json',
                  )),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [

                    Text(
                      'Our Mission',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      '>Stop 1,00,000 kg food from getting wasted .',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      '>Successfully distributing atleast 75% of the total food stock.',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),
                    ),


                  ],
                ),
              ),

              SizedBox(height: 20,),

              SizedBox(
                  height: 30,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => UserPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEC4C47),
                      foregroundColor: Colors.black,
                    ),
                    child: const Text("Continue"),
                  )),

            ],
          ),
        ),
      ),
    );
  }
}