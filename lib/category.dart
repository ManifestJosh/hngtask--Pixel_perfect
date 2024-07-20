import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixel_perfect/Api.dart';
import 'package:pixel_perfect/controller/cartcontroller.dart';

import 'controller/bottomnav.dart';
import 'productsdetails.dart';

class CategoryProductsPage extends StatelessWidget {
  final CartController cartController;
  final String categoryName;
  final List<Products> products;
  final BottomNavigationController controller;

  CategoryProductsPage(
      {required this.categoryName,
      required this.products,
      required this.controller,
      required this.cartController});

  @override
  Widget build(BuildContext context) {
    final categoryProducts = products
        .where((product) => product.categories.contains(categoryName))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: categoryProducts.isEmpty
          ? Center(child: Text('No products available in this category'))
          : Padding(
              padding: const EdgeInsets.all(18.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: categoryProducts.length,
                itemBuilder: (context, index) {
                  final product = categoryProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => Productsdetails(
                            product: product,
                            controller: controller,
                            cartController: cartController,
                            allProducts: [],
                          ));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 168,
                          height: 138,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                width: 0.5, color: Colors.grey.shade300),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(32)),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                right: 40,
                                child: Image.network(
                                  product.imageUrl,
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text("Athletic/Sportswear"),
                        Text(
                          product.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/rate.png",
                              width: 10,
                              height: 10,
                            ),
                            Text("4.5 (100 sold)")
                          ],
                        ),
                        Text(
                          'NGN ${product.price}',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
