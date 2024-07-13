import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixel_perfect/cart.dart';
import 'package:pixel_perfect/controller/bottomnav.dart';
import 'package:pixel_perfect/homepage.dart';

void main() {
  final BottomNavigationController controller;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade700),
        useMaterial3: true,
      ),
      // home: Homepage(),
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => Homepage()),
        //GetPage(name: '/all-products', page: () => AllProductsPage()),
        GetPage(
            name: '/cart',
            page: () => CartPage(
                  checkoutItems: [],
                )),
        //GetPage(name: '/my-order', page: () => MyOrderPage()),
        //GetPage(name: '/profile', page: () => ProfilePage()),
      ],
    );
  }
}
