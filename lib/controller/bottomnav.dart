import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixel_perfect/controller/cartcontroller.dart';
import 'package:pixel_perfect/products.dart';

import '../cart.dart';
import '../homepage.dart';
import '../orderpage.dart';

class BottomNavigationController extends GetxController {
  final CartController cartController;
  var currentIndex = 0.obs;

  BottomNavigationController({required this.cartController});

  void changePage(int index) {
    currentIndex.value = index;
    switch (index) {
      case 0:
        Get.offAll(() => Homepage(
              cartController: cartController,
            ));
        break;
      case 1:
        Get.off(() => ProductsPage(
              bottomNavigationController: this,
              cartController: cartController,
            ));
        break;
      case 2:
        Get.off(() => CartPage(
              cartController: cartController,
              bottomNavigationController: this,
            ));
        break;
      case 3:
        Get.off(() => OrderHistoryPage(
              bottomNavigationController: this,
              cartController: cartController,
            ));
        break;
      case 4:
        // Get.off(()=> ProfilePage());
        break;
      default:
        Get.offAll(() => Homepage(
              cartController: cartController,
            ));
    }
  }
}

class BottomNavBar extends StatelessWidget {
  final CartController cartController;
  const BottomNavBar({
    super.key,
    required this.bottomNavigationController,
    required this.cartController,
  });

  final BottomNavigationController bottomNavigationController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.rectangle_3_offgrid),
              label: 'All Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.bag_fill),
              label: 'My Order',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: bottomNavigationController.currentIndex.value,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            bottomNavigationController.changePage(index);
          },
        );
      },
    );
  }
}
