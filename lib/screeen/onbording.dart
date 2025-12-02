import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nectar/screeen/login.dart';


class onbording extends StatefulWidget {
  const onbording({super.key});

  @override
  State<onbording> createState() => _onbordingState();
}

class _onbordingState extends State<onbording> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/onbording.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 190.h),
                Container(
                  height: 80.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/carrort.png'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    'Welcome',
                    style: TextStyle(color: Colors.white, fontSize: 40.sp),
                  ),
                ),
                Text(
                  'to our store',
                  style: TextStyle(color: Colors.white, fontSize: 40.sp),
                ),
                Text(
                  'Get your groceries in as fast as one hour',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 40.h),
                Container(
                  width: 350.w,
                  height: 70.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => login()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff53B175),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Get Started',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
