import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nectar/component/appColor.dart';
import 'package:nectar/screeen/bottomnav.dart';
import 'package:nectar/screeen/signup.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  loginUser() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login Successful")));

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Bottomnav()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "";

      if (e.code == 'user-not-found') {
        message = "No user found with this email.";
      } else if (e.code == 'wrong-password') {
        message = "Incorrect password.";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email format.";
      } else {
        message = "Login failed. Please try again.";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went wrong.")));
    }
  }

  forgetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password reset link has been sent to your email."),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = "";

      if (e.code == "user-not-found") {
        message = "No account found with this email.";
      } else if (e.code == "invalid-email") {
        message = "Invalid email format.";
      } else {
        message = "Something went wrong. Please try again.";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isPasswordHidden = true;
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 45.h),
              //LOGO
              Center(
                child: SizedBox(
                  width: 45.w,
                  height: 45.h,
                  child: Image(
                    image: AssetImage('assets/colorcarrort.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 60.h),
              //LOGIN
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              //ENTER YOUR EMAIL AND PASSWORD
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Enter your email and password'),
              ),
              SizedBox(height: 40.h),

              //EMAIL
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Email'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5.w),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              //PASSWORD
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Password'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  obscureText: isPasswordHidden,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5.w),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordHidden = !isPasswordHidden;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      if (emailController.text.isNotEmpty) {
                        forgetPassword();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please enter your email first."),
                          ),
                        );
                      }
                    },
                    child: Text('Forgot Password?'),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              //LOGIN BUTTON
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  height: 45.h,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        loginUser();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appColor.backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                    child: isLoading
                        ? SizedBox(
                            height: 24.h,
                            width: 24.h,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : Text('Log In', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              //DON'T HAVE AN ACCOUNT SIGN UP
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Signup()),
                      );
                    },
                    child: Text(
                      'Singup',
                      style: TextStyle(color: appColor.backgroundColor),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Bottomnav()),
                    );
                  },
                  child: Text('SKIP', style: TextStyle(fontSize: 20.sp)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
