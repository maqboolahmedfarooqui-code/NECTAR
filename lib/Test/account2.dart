import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<Map<String, dynamic>?> getUserData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    return snap.data() as Map<String, dynamic>?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var user = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Username: ${user["username"]}", style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Text("Email: ${user["email"]}", style: TextStyle(fontSize: 20)),
              ],
            ),
          );
        },
      ),
    );
  }
}