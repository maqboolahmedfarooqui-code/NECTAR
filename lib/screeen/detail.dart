import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nectar/screeen/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Detail extends StatefulWidget {
  final String pPic;
  final String pName;
  final String pDis;
  final String pPrice;
  final String pDetail;
  final String heroTag;

  const Detail({
    super.key,
    required this.pPic,
    required this.pName,
    required this.pDis,
    required this.pPrice,
    required this.pDetail,
    required this.heroTag
  });

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool isFavourite = false;

  @override
  void initState() {
    super.initState();
    checkFavourite();
  }

  Future<void> checkFavourite() async {
    final prefs = await SharedPreferences.getInstance();
    final String? store = prefs.getString('favourite');

    List favourite = store != null ? jsonDecode(store) : [];

    // Check if current item exists by name/pic
    isFavourite = favourite.any((item) => item['name'] == widget.pName);

    setState(() {});
  }

  Future<void> toggleFavourite() async {
    final prefs = await SharedPreferences.getInstance();
    final String? store = prefs.getString('favourite');

    List favourite = store != null ? jsonDecode(store) : [];

    if (isFavourite) {
      // If true → remove item
      favourite.removeWhere((item) => item['name'] == widget.pName);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Removed from Favourite")));
    } else {
      // If false → add item
      favourite.add({
        'pic': widget.pPic,
        'name': widget.pName,
        'dis': widget.pDis,
        'price': widget.pPrice,
        'detail': widget.pDetail,
        'hero': widget.heroTag
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Added to Favourite")));
    }

    // Save updated list
    await prefs.setString('favourite', jsonEncode(favourite));

    // Toggle state
    setState(() {
      isFavourite = !isFavourite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //APP BAR
      appBar: AppBar(
        title: Text(
          'Detail',
          style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //PIC
          Hero(
            tag: widget.heroTag,
            child: Container(
              width: double.infinity,
              height: 250.h,
              decoration: BoxDecoration(color: Color(0xffF2F3F2)),
              child: ClipRRect(child: Image(image: AssetImage(widget.pPic))),
            ),
          ),

          // NAME
          SizedBox(height: 10.h),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  widget.pName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  onPressed: toggleFavourite,
                  icon: Icon(
                    isFavourite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),

          // DIS
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(widget.pDis),
          ),

          // PRICE
          SizedBox(height: 10.h),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              widget.pPrice,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
            ),
          ),

          // DIVIDER
          SizedBox(height: 25.h),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Divider(
              color: Colors.grey,
              thickness: 0.3,
              height: 20.h,
              indent: 10,
              endIndent: 10,
            ),
          ),

          //DETAIL
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Product Detail',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 5.h),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(widget.pDetail, style: TextStyle()),
          ),
          SizedBox(height: 30.h),

          // ADD TO BASKET
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Container(
              width: double.infinity,
              height: 45.h,
              child: ElevatedButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();

                  final String? store = prefs.getString('cartitems');

                  // Pehle old cart load karo
                  List cartitems = store != null ? jsonDecode(store) : [];

                  cartitems.add({
                    'pic': widget.pPic,
                    'name': widget.pName,
                    'dis': widget.pDis,
                    'price': widget.pPrice,
                  });

                  await prefs.setString('cartitems', jsonEncode(cartitems));

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Added to cart")));
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => cart()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff53B175),
                ),
                child: Text(
                  'Add To Basket',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
