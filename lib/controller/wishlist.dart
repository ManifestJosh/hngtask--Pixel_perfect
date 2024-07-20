import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixel_perfect/Api.dart';
import 'package:pixel_perfect/productsdetails.dart';

class WishlistController extends GetxController {
  var wishlist = <Products>[].obs;
  List<Products> get products => wishlist.toList();

  void addToWishlist(Products product) {
    wishlist.add(product);
    Get.snackbar(
        "Successfully added", "Check Wishlist Page to see your Wishlist",
        backgroundColor: Colors.blue, colorText: Colors.white);
  }

  void removeFromWishlist(Products product) {
    wishlist.remove(product);
  }
}

class WishlistPage extends StatelessWidget {
  final List<Products> products;
  final WishlistController wishlistController = Get.find<WishlistController>();

  WishlistPage({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Wishlist",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      )),
      body: Obx(() {
        return ListView.builder(
          itemCount: wishlistController.wishlist.length,
          itemBuilder: (context, index) {
            final product = wishlistController.wishlist[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => Productsdetails(
                      product: product,
                      controller: Get.find(),
                      cartController: Get.find(),
                      allProducts: products));
                },
                child: ListTile(
                  leading: Image.network(product.imageUrl),
                  title: Text(product.name),
                  subtitle: Text('NGN ${product.price}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      wishlistController.removeFromWishlist(product);
                    },
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
