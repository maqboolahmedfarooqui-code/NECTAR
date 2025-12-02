import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nectar/screeen/detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class favourite extends StatefulWidget {
  const favourite({super.key});

  @override
  State<favourite> createState() => _favouriteState();
}

class _favouriteState extends State<favourite> {
  List favourite = [];

  Future<void> loadfavourite() async {
    final prefs = await SharedPreferences.getInstance();
    final String? store = prefs.getString('favourite');
    setState(() {
      favourite = store != null ? jsonDecode(store) : [];
    });
  }

  @override
  void initState() {
    super.initState();
    loadfavourite(); // Screen load hote hi favourites load ho jayein
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40.h),
          Center(
            child: Text(
              'Favourite',
              style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 15.h),
          Divider(color: Colors.black, thickness: 1, indent: 20, endIndent: 20),
          SizedBox(height: 10.h),
          Expanded(
            child: favourite.isEmpty
                ? Expanded(child: Center(child: Text('Favourite is Empty', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),)))
                : ListView.builder(
                    itemCount: favourite.length,
                    itemBuilder: (context, index) {
                      final items = favourite[index];
                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Detail(
                                    pPic: items['pic']!,
                                    pName: items['name']!,
                                    pDis: items['dis']!,
                                    pPrice: items['price']!,
                                    pDetail: items['detail'],
                                    heroTag: items['hero'],
                                  ),
                                ),
                              );
                            },
                            leading: Image(image: AssetImage(items['pic']!)),
                            title: Text(
                              items['name']!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.sp,
                              ),
                            ),
                            subtitle: Text(items['dis']!),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  items['price']!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp,
                                  ),
                                ),
                                Icon(Icons.arrow_right_sharp, size: 50),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                            indent: 40,
                            endIndent: 40,
                          ),
                          SizedBox(height: 10.h),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
