import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nectar/screeen/detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class shop extends StatefulWidget {
  const shop({super.key});

  @override
  State<shop> createState() => _shopState();
}

class _shopState extends State<shop> {
  List<String> slider = [
    'assets/mainbanner.png',
    'assets/freshmeat.jpg',
    'assets/banner.jpg',
    'assets/banner2.jpg',
    'assets/banner3.jpg',
  ];

  List<Map<String, String>> cards = [
    {
      'pic': 'assets/banana.png',
      'name': 'Organic Bananas',
      'dis': '7pcs, Price',
      'detail':
          'Banana is a nutritious fruit rich in potassium, fiber, and vitamins that help boost energy and improve digestion.',
      'price': '\$0.67',
      'hero': 'bananaHero',
      'quantity': '1'
    },
    {
      'pic': 'assets/apple.png',
      'name': 'Red Apple',
      'dis': '1Kg, Price',
      'detail':
          'Apple is a nutritious fruit rich in fiber, vitamins, and antioxidants that help keep the body healthy and strong.',
      'price': '\$3.33',
      'hero': 'appleHero',
      'quantity': '1'
    },
    {
      'pic': 'assets/beef.png',
      'name': 'Beef Bone',
      'dis': '1Kg, Price',
      'detail':
          'Beef is a rich source of high-quality protein, iron, zinc, and vitamin B12, which help build muscles.',
      'price': '\$20.00',
      'hero': 'beefHero',
      'quantity': '1'
    },
    {
      'pic': 'assets/chicken.png',
      'name': 'Broiler Chicken',
      'dis': '1Kg, Price',
      'detail':
          'Chicken is a lean, nutrient-rich source of high-quality protein along with vitamins (B6, B12, Niacin)',
      'price': '\$5.23',
      'hero': 'chickenHero',
      'quantity': '1'
    },
    {
      'pic': 'assets/pepper.png',
      'name': 'Bell Pepper Red',
      'dis': '1Kg, Price',
      'detail':
          'Red bell peppers are nutrient-dense: they are rich in vitamins A and C, fiber, and antioxidants that support eye health.',
      'price': '\$2.20',
      'hero': 'bellpepperHero',
      'quantity': '1'
    },
    {
      'pic': 'assets/ginger.png',
      'name': 'Ginger',
      'dis': '250gm, Price',
      'detail':
          'Ginger is rich in bioactive compounds such as gingerol that help improve digestion, reduce nausea.',
      'price': '\$1.23',
      'hero': 'gingerHero',
      'quantity': '1'
    },
    {
      'pic': 'assets/redegg2.jpg',
      'name': 'Egg Chicken Red',
      'dis': '4pcs, Price',
      'detail':
          'Red eggs are nutrient-rich and a great source of high-quality protein, vitamin B12, iron, and healthy fats.',
      'price': '\$1.65',
      'hero': 'eggchickenredHero',
      'quantity': '1'
    },
    {
      'pic': 'assets/eggwhite.png',
      'name': 'Egg Chicken White',
      'dis': '180g, Price',
      'detail':
          'Egg White is the clear part of an egg rich in high-quality protein but low in fat and calories, making it ideal for a healthy diet.',
      'price': '\$6.17',
      'hero': 'eggwhiteHero',
      'quantity': '1'
    },
    {
      'pic': 'assets/eggpasta.png',
      'name': 'Egg Pasta',
      'dis': '30gm, Price',
      'detail':
          'The eggs add extra protein compared to regular pasta, helping in muscle growth and repair.',
      'price': '\$1.30',
      'hero': 'eggpastaHero',
      'quantity': '1'
    },
    {
      'pic': 'assets/eggnoodle.png',
      'name': 'Egg Noodle',
      'dis': '2L, Price',
      'detail':
          'Egg noodles are enriched with vitamins and minerals (like selenium, thiamine, folate) which help immune function and overall nutrition.',
      'price': '\$1.29',
      'hero': 'eggnoodleHero',
      'quantity': '1'
    },
    {
      'pic': 'assets/mayonnaise.png',
      'name': 'Mayonnais Eggless',
      'dis': '325ml, Price',
      'detail':
          'Mayonnaise contains healthy unsaturated fats (from the vegetable oil base) which help with the absorption of fat-soluble vitamins (A, D, E, K) in other foods.',
      'price': '\$3.50',
      'hero': 'mayonnaiseHero',
      'quantity': '1'
    },
    {
      'pic': 'assets/noodle.png',
      'name': 'Noodles',
      'dis': '330ml, Price',
      'detail':
          'Egg noodles provide extra protein (due to added eggs) compared to plain wheat pasta, which helps in muscle repair and satiety.',
      'price': '\$1.50',
      'hero': 'noodleHero',
      'quantity': '1'
    },
    {
      'pic': 'assets/coke.png',
      'name': 'Diet Coke',
      'dis': '355ml, Price',
      'detail':
          'Diet Coke is a zero‐sugar, zero‐calorie cola beverage, making it a popular choice for those monitoring calorie intake.',
      'price': '\$0.50',
      'hero': 'dietcokeHero',
      'quantity': '1'
    },
    {
      'pic': 'assets/sprite.png',
      'name': 'Sprite Can',
      'dis': '325ml, Price',
      'detail':
          'Refreshing & Hydrating: Provides quick refreshment, especially on hot days.',
      'price': '\$1.00',
      'hero': 'spriteHero',
      'quantity': '1'
    },
    {
      'pic': 'assets/applejuice.png',
      'name': 'Apple Juice',
      'dis': '2L, Price',
      'detail':
          'A blend of apple + grape juice supplies multiple fruit sources of vitamin C, polyphenols, and antioxidants — grapes contribute good flavonoids, apples offer fiber (if pulp) and other nutrients.',
      'price': '\$2.79',
      'hero': 'appleJuiceHero',
      'quantity': '1'
    },
    {
      'pic': 'assets/orangejuice.png',
      'name': 'Orenge Juice',
      'dis': '2L, Price',
      'detail':
          'Orange juice is rich in vitamin C, which supports the immune system, helps with collagen formation (skin health), and aids in iron absorption.',
      'price': '\$4.00',
      'hero': 'orangeJuiceHero',
      'quantity': '1'
    },
    {
      'pic': 'assets/cocacola.png',
      'name': 'Coca Cola Can',
      'dis': '325ml, Price',
      'detail':
          'Coca‑Cola is a globally recognized carbonated soft drink, known for its crisp, sweet taste and signature red branding.',
      'price': '\$0.50',
      'hero': 'cocaColaCanHero',
      'quantity': '1'
    },
    {
      'pic': 'assets/pepsi.png',
      'name': 'Pepsi Can',
      'dis': '330ml, Price',
      'detail':
          'It’s convenient for on‑the‑go refreshment, consumed chilled for best taste.',
      'price': '\$0.40',
      'hero': 'pepsiCanHero',
      'quantity': '1'
    },
  ];

 //SEARCH PRODUT FUNCTION
  List<Map<String, String>> filteredProducts = [];
  
  void searchProducts(String query) {
    final result = cards.where((items) {
      final productname = items['name']?.toLowerCase();
      final input = query.toLowerCase();
      return productname!.contains(input);
    }).toList();
    setState(() {
      filteredProducts = result;
    });
  }
  
  //USER CITY GET FUNCTION
  Future<String> getUserCity() async {
    // Check permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // Get current position
    Position pos = await Geolocator.getCurrentPosition(
      // ignore: deprecated_member_use
      desiredAccuracy: LocationAccuracy.high,
    );

    // Convert lat/lng → address
    List<Placemark> placemarks = await placemarkFromCoordinates(
      pos.latitude,
      pos.longitude,
    );

    // City name
    return placemarks[0].locality ?? "Unknown";
  }

  String currentcity = 'Loading...';

  loadcity() async {
    String city = await getUserCity();
    setState(() {
      currentcity = city;
    });
  }

  @override
  void initState() {
    super.initState();
    filteredProducts = cards;
    loadcity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            // Carrort icon
            Center(
              child: Container(
                height: 60.h,
                width: 60.w,
                child: const Image(
                  image: AssetImage('assets/colorcarrort.png'),
                ),
              ),
            ),

            // Location
            Center(
              child: Text(
                currentcity,
                style:  TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10.h),

            // Search Bar
            Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  onChanged: searchProducts,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffF2F2F3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    ),
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search',
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),

            //Slider
            CarouselSlider(
              items: slider.map((imagePath) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                autoPlay: true,
                height: 110.h,
                enlargeCenterPage: true,
              ),
            ),
            SizedBox(height: 10.h),
            //Groceries
            Text(
              'Groceries',
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10.h),
            //Menu
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.65,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Detail(
                            pPic: filteredProducts[index]['pic']!,
                            pName: filteredProducts[index]['name']!,
                            pDis: filteredProducts[index]['dis']!,
                            pPrice: filteredProducts[index]['price']!,
                            pDetail: filteredProducts[index]['detail']!,
                            heroTag:
                                filteredProducts[index]['hero'] ??
                                'defaultHero',
                          ),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      elevation: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10.r),
                                ),
                                child: Hero(
                                  tag:
                                      filteredProducts[index]['hero'] ??
                                      'defaultHero',
                                  child: Image.asset(
                                    filteredProducts[index]['pic']!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              filteredProducts[index]['name']!,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              filteredProducts[index]['dis']!,
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Text(
                                  filteredProducts[index]['price']!,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: IconButton(
                                    onPressed: () async {
                                      final prefs =
                                          await SharedPreferences.getInstance();

                                      final String? store = prefs.getString(
                                        'cartitems',
                                      );

                                      // Pehle old cart load karo
                                      List cartitems = store != null
                                          ? jsonDecode(store)
                                          : [];

                                      cartitems.add({
                                        'pic': filteredProducts[index]['pic']!,
                                        'name':
                                            filteredProducts[index]['name']!,
                                        'dis': filteredProducts[index]['dis']!,
                                        'price':
                                            filteredProducts[index]['price']!,
                                        'detail':
                                            filteredProducts[index]['detail']!,
                                        'hero':
                                            filteredProducts[index]['hero']!,
                                            'quantity':filteredProducts[index]['quantity']!
                                      });

                                      await prefs.setString(
                                        'cartitems',
                                        jsonEncode(cartitems),
                                      );

                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text("Added to cart"),
                                        ),
                                      );
                                    },

                                    icon: Icon(Icons.shopping_cart),
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
