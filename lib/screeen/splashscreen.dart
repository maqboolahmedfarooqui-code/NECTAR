import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nectar/screeen/bottomnav.dart';
import 'package:nectar/screeen/onbording.dart';


class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  // SPLASH SCREEN FUNCTION
  checkLogin() async {
    await Future.delayed(Duration(seconds: 2));
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Bottomnav()),
      );
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => onbording()));
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff53B175),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 250.h),
            Image.asset("assets/logo.png"),
            SizedBox(height: 25.h),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
