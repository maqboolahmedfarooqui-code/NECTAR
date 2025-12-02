import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nectar/component/CustomListTile.dart';
import 'package:nectar/screeen/login.dart';

class account extends StatefulWidget {
  const account({super.key});

  @override
  State<account> createState() => _accountState();
}

class _accountState extends State<account> {
  logoutUser() async {
    await FirebaseAuth.instance.signOut();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Successfully Logged Out")));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => login()),
    );
  }

  // List notes = [];

  @override
  void initState() {
    super.initState();
    // load();
  }

  // Future<void> load() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final String? store = prefs.getString('notes');
  //   store != null
  //       ? setState(() {
  //           notes = jsonDecode(store);
  //         })
  //       : setState(() {
  //           notes = [];
  //         });
  // }

  Future<Map<String, dynamic>?> getUserData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    return snap.data() as Map<String, dynamic>?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            FutureBuilder(
              future: getUserData(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                var user = snapshot.data!;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 15.h,),
                    Text(user['username'],style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      ),),
                      Text(user['email'])
                  ],
                );
              },
            ),
            SizedBox(height: 10.h,),
            //CENTER LINE
            Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),

            CustomListTile(icon: Icons.shopping_bag, text: 'Order'),

            //CENTER LINE
            Divider(
              color: Colors.grey,
              thickness: 0.5,
              indent: 20,
              endIndent: 20,
            ),

            // MY DETAILS
            CustomListTile(icon: Icons.card_membership, text: 'My Details'),

            //CENTER LINE
            Divider(
              color: Colors.grey,
              thickness: 0.5,
              indent: 20,
              endIndent: 20,
            ),

            // DELEVERY ADDRESS
            CustomListTile(icon: Icons.location_on, text: 'Delivery Address'),

            //CENTER LINE
            Divider(
              color: Colors.grey,
              thickness: 0.5,
              indent: 20,
              endIndent: 20,
            ),

            // PAYMENT METHODS
            CustomListTile(
              icon: Icons.credit_card_outlined,
              text: 'Payment Methods',
            ),

            //CENTER LINE
            Divider(
              color: Colors.grey,
              thickness: 0.5,
              indent: 20,
              endIndent: 20,
            ),

            // PROMO CORD
            CustomListTile(icon: Icons.discount, text: 'Promo Code'),

            //CENTER LINE
            Divider(
              color: Colors.grey,
              thickness: 0.5,
              indent: 20,
              endIndent: 20,
            ),

            // NOTIFICATION
            CustomListTile(
              icon: Icons.notification_add_outlined,
              text: 'Notification',
            ),

            //CENTER LINE
            Divider(
              color: Colors.grey,
              thickness: 0.5,
              indent: 20,
              endIndent: 20,
            ),

            // HELP
            CustomListTile(icon: Icons.help, text: 'Help'),
            //CENTER LINE
            Divider(
              color: Colors.grey,
              thickness: 0.5,
              indent: 20,
              endIndent: 20,
            ),

            // ABOUT
            CustomListTile(icon: Icons.circle_outlined, text: 'About'),

            SizedBox(height: 30.h),

            // LOG OUT
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: InkWell(
                onTap: () {
                  // final prefs = await SharedPreferences.getInstance();
                  // await prefs.remove('notes');
                  // setState(() {
                  //   notes.clear(); // ← List ko bhi empty kar dena zaroori hai
                  // });
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Signup()),
                  // );
                  // FirebaseAuth.instance.signOut();

                  logoutUser();
                },
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Color(0xffF2F3F2),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.green),
                      Text('Log Out', style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
