import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nectar/component/appColor.dart';
import 'package:nectar/screeen/login.dart';


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  Future<void> registerUser(
    String email,
    String password,
    String username,
  ) async {
    try {
      // Create user in Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;

      // Save data in Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        "username": username,
        "email": email,
        "uid": uid,
      });

      print("User Registered + Data Saved");
    } catch (e) {
      print("Error: $e");
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // registerUser() async {
  //   try {
  //     FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: emailController.text,
  //       password: passwordController.text,
  //     );
  //     Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text('Successfully Sing Up')));
  //   } catch (e) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text(e.toString())));
  //   }
  // }

  // File? image;
  // final ImagePicker picker = ImagePicker();

  // Future<void> galleryimg() async {
  //   final pickedimg = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedimg != null) {
  //     setState(() {
  //       image = File(pickedimg.path);
  //     });
  //   }
  // }


  // Future<void> save() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final String? store = prefs.getString('notes');
  //   List notes = store != null ? jsonDecode(store) : [];

  //   notes.add({
  //     'pic': image?.path,
  //     'name': nameController.text.trim(),
  //     'email': emailController.text.trim(),
  //   });
  //   await prefs.setString('notes', jsonEncode(notes));
  // }

  bool isLoading = false;
  bool ispassword = false;
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 45.h),
            Center(
              child: Container(
                height: 45.h,
                width: 45.w,
                child: const Image(
                  image: AssetImage('assets/colorcarrort.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            // Sign Up
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Sign Up',
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10.h),

            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text('Enter your credentials to continue'),
            ),
            //Name
            SizedBox(height: 30.h),
            //FORM
            Form(
              key: formkey,
              child: Column(
                children: [
                  //Username
                  SizedBox(height: 20.h),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(label: Text('Username')),
                    ),
                  ),

                  //EMAIL
                  SizedBox(height: 20.h),

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
                      decoration: InputDecoration(label: Text('Email')),
                    ),
                  ),

                  //PASSWORD
                  SizedBox(height: 20.h),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      obscureText: ispassword,
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text('Password'),
                        suffixIcon: IconButton(
                          icon: Icon(
                            ispassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              ispassword = !ispassword;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.h),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });

                      await registerUser(
                        emailController.text,
                        passwordController.text,
                        nameController.text,
                      );
                      setState(() {
                        isLoading = false;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Account Created Successfully")),
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => login()),
                      );
                    }
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff53B191),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: isLoading
                      ? SizedBox(
                          height: 24.h,
                          width: 24.h,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3.w,
                          ),
                        )
                      : Text('Sign Up', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? "),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => login()),
                    );
                  },
                  child: Text(
                    'Log In',
                    style: TextStyle(color: appColor.backgroundColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
