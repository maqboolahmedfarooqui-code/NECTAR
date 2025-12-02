import 'package:flutter/material.dart';
import 'package:nectar/screeen/account.dart';
import 'package:nectar/screeen/cart.dart';
import 'package:nectar/screeen/Favourite.dart';
import 'package:nectar/screeen/shop.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {

  int selectindex = 0;
  final List<Widget> page = [
    shop(),
    cart(),
    favourite(),
    account(),
  ];

  @override
  Widget build(BuildContext context) {
                                                                                 
    return Scaffold(
      body: page[selectindex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        currentIndex: selectindex,
        onTap: (index) {
          if (mounted) {
            setState(() {
              selectindex = index;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favourite'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}
