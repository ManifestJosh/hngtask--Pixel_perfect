import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixel_perfect/Api.dart';
import 'package:pixel_perfect/controller/cartcontroller.dart';
import 'package:pixel_perfect/controller/wishlist.dart';

import 'controller/bottomnav.dart';
import 'productsdetails.dart';

class ProductsPage extends StatefulWidget {
  final BottomNavigationController bottomNavigationController;
  final CartController cartController;
  const ProductsPage({
    super.key,
    required this.bottomNavigationController,
    required this.cartController,
  });

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final TimbuApi timbuApi = TimbuApi();
  final WishlistController wishlistController = Get.put(WishlistController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Products",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<Products>>(
          future: timbuApi.fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No products available'));
            } else {
              final products = snapshot.data!;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 390,
                    height: 2670,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 350,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => Productsdetails(
                                  product: product,
                                  controller: widget.bottomNavigationController,
                                  cartController: widget.cartController,
                                  allProducts: products,
                                ));
                          },
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 168,
                                  height: 250,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 0.5,
                                        color: Colors.grey.shade300),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(32)),
                                  ),
                                  child: Stack(children: [
                                    Positioned(
                                        top: 10,
                                        right: 10,
                                        child: InkWell(
                                          onTap: () {
                                            wishlistController
                                                .toggleFavorite(product);
                                          },
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: wishlistController.products
                                                      .contains(product)
                                                  ? Colors.red
                                                  : Colors.grey.shade400,
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),
                                            child: Icon(
                                              wishlistController.products
                                                      .contains(product)
                                                  ? Icons.favorite
                                                  : Icons
                                                      .favorite_border_outlined,
                                              size: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )),
                                    Positioned(
                                      top: 150,
                                      left: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(() => Productsdetails(
                                                product: product,
                                                controller: widget
                                                    .bottomNavigationController,
                                                cartController:
                                                    widget.cartController,
                                                allProducts: products,
                                              ));
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Athletic/Sportswear"),
                                            Text(
                                              product.name,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                  "assets/rate.png",
                                                  width: 10,
                                                  height: 10,
                                                ),
                                                const Text("4.5 (100 sold)")
                                              ],
                                            ),
                                            Text(
                                              'NGN ${product.price}',
                                              style: const TextStyle(
                                                  color: Colors.blue),
                                            ),
                                            Text(
                                              'NGN ${product.price * 2}',
                                              style: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          final productMap = {
                                            'product image':
                                                products[index].imageUrl,
                                            'product': products[index].name,
                                            'price': products[index].price,
                                            'quantity':
                                                products[index].quantity,
                                          };
                                          widget.cartController
                                              .addItem(productMap);
                                        },
                                        child: Container(
                                            width: 36,
                                            height: 28,
                                            decoration: BoxDecoration(
                                                color: Colors.blue.shade100,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(16))),
                                            child: const Icon(
                                              CupertinoIcons.shopping_cart,
                                              size: 15,
                                              color: Colors.blue,
                                            )),
                                      ),
                                    ),
                                    Positioned(
                                      top: 20,
                                      right: 40,
                                      child: Image.network(
                                        product.imageUrl,
                                        width: 100,
                                        height: 100,
                                      ),
                                    ),
                                  ]),
                                ),
                              ]),
                        );
                      },
                    ),
                  ),
                ),
              );
            }
          }),
      bottomNavigationBar: BottomNavBar(
        bottomNavigationController: widget.bottomNavigationController,
        cartController: widget.cartController,
      ),
    );
  }
}
