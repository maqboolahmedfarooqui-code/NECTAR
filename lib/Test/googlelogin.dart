import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoogleLoginScreen extends StatelessWidget {
  const GoogleLoginScreen({super.key});

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCredential.user;

      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .set({
        "username": user.displayName,
        "email": user.email,
        "uid": user.uid,
      }, SetOptions(merge: true));

      Navigator.pushReplacementNamed(context, "/home");

    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // App Logo
              Icon(Icons.account_circle, size: 120, color: Colors.blue),

              const SizedBox(height: 20),

              const Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Sign in to continue",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),

              const SizedBox(height: 50),

              // Google Login Button
              GestureDetector(
                onTap: () => loginWithGoogle(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/640px-Google_%22G%22_Logo.svg.png",
                        height: 25,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "Sign in with Google",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}