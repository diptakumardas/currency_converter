import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../view_screen/dashboard.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 4), () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashBoard()));});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height*.7,
            width: MediaQuery.sizeOf(context).width*1,
            color: Colors.white,
            child: Center(
              child: Image.asset('assets/images/money.jpg',filterQuality: FilterQuality.high,fit: BoxFit.cover,),

            ),
          ),
          Text("Currency Converter",style: GoogleFonts.palanquinDark(fontSize: 40,color: Colors.black)
    ,),
          SizedBox(
            height: 80,
          ),
          SpinKitDualRing(color: Colors.black,size: 50,)
        ],
      ),


    );
  }
}
