import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nectar/screeen/detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class cart extends StatefulWidget {
  const cart({super.key});

  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
  String selectedvalue = 'Card';
  List cartitems = [];

  @override
  void initState() {
    super.initState();
    loadcartitems();
  }

  Future<void> loadcartitems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? store = prefs.getString('cartitems');
    setState(() {
      cartitems = store != null ? jsonDecode(store) : [];
    });
  }

  Future<void> deleteItem(int index) async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      cartitems.removeAt(index);
    });

    await prefs.setString('cartitems', jsonEncode(cartitems));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40.h),
          Center(
            child: Text(
              'My Cart',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(height: 15.h),
          Divider(color: Colors.grey, thickness: 1, indent: 20, endIndent: 20),
          cartitems.isEmpty
              ? Expanded(
                  child: Center(
                    child: Text(
                      'Cart is Empty',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: cartitems.length,
                    itemBuilder: (context, index) {
                      // Price ko number me convert karte waqt
                      String priceStr =
                          cartitems[index]['price'] ??
                          '0'; // agar null ho toh '0'
                      double price =
                          double.tryParse(priceStr.replaceAll('\$', '')) ?? 0;

                      // Quantity ko number me convert karte waqt
                      String quantityStr =
                          cartitems[index]['quantity'] ??
                          '1'; // agar null ho toh '1'
                      int quantity = int.tryParse(quantityStr) ?? 1;

                      double totalPrice = price * quantity;

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Detail(
                                pPic: cartitems[index]['pic'],
                                pName: cartitems[index]['name'],
                                pDis: cartitems[index]['dis'],
                                pPrice: cartitems[index]['price'],
                                pDetail: cartitems[index]['detail'],
                                heroTag: cartitems[index]['hero'],
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            SizedBox(height: 10.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // IMAGE
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: ClipRRect(
                                    child: Image(
                                      image: AssetImage(
                                        cartitems[index]['pic'],
                                      ),
                                      width: 60.w,
                                      height: 60.h,
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: 20.w,
                                ), // space between image and text
                                // NAME & DESCRIPTION
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cartitems[index]['name'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                      Text(cartitems[index]['dis']),
                                      SizedBox(height: 9.h),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                int currentQty =
                                                    int.tryParse(
                                                      cartitems[index]['quantity'] ??
                                                          '1',
                                                    ) ??
                                                    1;
                                                if (currentQty > 1)
                                                  currentQty--;
                                                cartitems[index]['quantity'] =
                                                    currentQty.toString();
                                              });
                                            },
                                            child: Text(
                                              '--',
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 7.w),
                                          Text('$quantity'),
                                          SizedBox(width: 7.w),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                int currentQty =
                                                    int.tryParse(
                                                      cartitems[index]['quantity'] ??
                                                          '1',
                                                    ) ??
                                                    1;
                                                currentQty++;
                                                cartitems[index]['quantity'] =
                                                    currentQty.toString();
                                              });
                                            },
                                            child: Text(
                                              '+',
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                Spacer(), // ← THIS pushes right side items to the end
                                // DELETE + PRICE
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 40,
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            deleteItem(index);
                                          },
                                          icon: Icon(Icons.cancel_outlined),
                                        ),
                                      ),

                                      Text(
                                        '\$${totalPrice.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 10.h),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              child: Divider(
                                color: Colors.grey,
                                thickness: 0.5,
                                indent: 20,
                                endIndent: 20,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
          SizedBox(height: 20.h),
          cartitems.isEmpty
              ? Text('')
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff53B175),
                      minimumSize: Size(double.infinity, 60.h),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (context, setState2) {
                              return Container(
                                height: 400.h,
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 30,
                                            left: 20,
                                          ),
                                          child: Text(
                                            'Checkout',
                                            style: TextStyle(
                                              fontSize: 23.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 30,
                                            right: 20,
                                          ),
                                          child: Icon(
                                            Icons.cancel_outlined,
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15.h),
                                    Divider(color: Colors.grey, thickness: 0.5),
                                    SizedBox(height: 10.h),

                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 20,
                                          ),
                                          child: Text(
                                            'Delivery',
                                            style: TextStyle(fontSize: 18.sp),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 20,
                                          ),
                                          child: DropdownButton(
                                            value: selectedvalue,
                                            items: [
                                              DropdownMenuItem(
                                                value: 'Card',
                                                child: Text('Card'),
                                              ),
                                              DropdownMenuItem(
                                                value: 'Cash',
                                                child: Text('Cash'),
                                              ),
                                            ],
                                            onChanged: (value) {
                                              setState2(() {
                                                selectedvalue = value!;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Divider(color: Colors.grey, thickness: 0.5),
                                    SizedBox(height: 10.h),

                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 20,
                                          ),
                                          child: Text(
                                            'Promo Code',
                                            style: TextStyle(fontSize: 18.sp),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 20,
                                          ),
                                          child: SizedBox(
                                            width: 90.w,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                hintText: ' Code',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 10.h),
                                    Divider(color: Colors.grey, thickness: 0.5),
                                    SizedBox(height: 10.h),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    child: Text(
                      'Go to Checkout',
                      style: TextStyle(color: Colors.white, fontSize: 18.sp),
                    ),
                  ),
                ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
