import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../Api.dart';
import '../productsdetails.dart';

class WishlistController extends GetxController {
  var wishlist = <Products>[].obs;

  List<Products> get products => wishlist.toList();

  void addToWishlist(Products product) {
    if (!wishlist.contains(product)) {
      wishlist.add(product);
      Get.snackbar(
        "Successfully added",
        "Check Wishlist Page to see your Wishlist",
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
    }
  }

  void removeFromWishlist(Products product) {
    wishlist.remove(product);
  }

  void toggleFavorite(Products product) {
    if (wishlist.contains(product)) {
      removeFromWishlist(product);
    } else {
      addToWishlist(product);
    }
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
        ),
      ),
      body: Obx(() {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.7,
          ),
          itemCount: wishlistController.wishlist.length,
          itemBuilder: (context, index) {
            final product = wishlistController.wishlist[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => Productsdetails(
                    product: product,
                    controller: Get.find(),
                    cartController: Get.find(),
                    allProducts: products));
              },
              child: Card(
                elevation: 4.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(
                      product.imageUrl,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'NGN ${product.price}',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Spacer(), // Adds space between price and button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            wishlistController.removeFromWishlist(product);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
