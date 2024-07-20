import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixel_perfect/Api.dart';
import 'package:pixel_perfect/category.dart';
import 'package:pixel_perfect/controller/bottomnav.dart';
import 'package:pixel_perfect/controller/cartcontroller.dart';
import 'package:pixel_perfect/products.dart';
import 'package:pixel_perfect/productsdetails.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'cart.dart';
import 'controller/wishlist.dart';

class Homepage extends StatefulWidget {
  final CartController cartController;
  const Homepage({
    super.key,
    required this.cartController,
  });

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TimbuApi timbuApi = TimbuApi();
  late BottomNavigationController bottomNavigationController;
  final PageController _controller = PageController();
  final WishlistController wishlistController = Get.put(WishlistController());
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_controller.hasClients) {
        final page = (_controller.page ?? 0).toInt();
        final nextPage = (page + 1) % 4; // Assuming you have 4 pages
        _controller.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
    bottomNavigationController =
        BottomNavigationController(cartController: widget.cartController);
  }

  void addToWishlist(Products product) {
    wishlistController.addToWishlist(product);
    Get.to(() => WishlistPage()); // Navigate to the wishlist page
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AG-Ezenard',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => WishlistPage());
            },
            icon: Icon(
              CupertinoIcons.heart,
              size: 40,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.search,
              size: 40,
              color: Colors.black,
            ),
          )
        ],
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
            List<String> categoryNames = products
                .expand((product) => product.categories)
                .toSet()
                .toList();
            List<Widget> avatars = categoryNames.map((categoryName) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => CategoryProductsPage(
                            categoryName: categoryName,
                            products: products,
                            controller: bottomNavigationController,
                            cartController: widget.cartController,
                          ));
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey.shade200,
                      child: Text(
                        categoryName[0].toUpperCase(),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    categoryName,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }).toList();
            avatars.add(
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey.shade200,
                    child: const Text(
                      "View All",
                      style: TextStyle(fontSize: 8, color: Colors.black),
                    ),
                  ),
                ],
              ),
            );

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 390,
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.amber,
                            child: Text(
                              "AD",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Good afternoon 👋🏽"),
                              Text("Ada Dennis"),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 232,
                      width: 390,
                      child: PageView.builder(
                        controller: _controller,
                        itemCount: 4,
                        itemBuilder: (_, index) => Container(
                          height: 340,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.black],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 40,
                                  ),
                                  Image.network(
                                    products[index].imageUrl,
                                    width: 100,
                                    height: 150,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Iconic Casual Brands",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 8),
                                      ),
                                      Text(
                                        '${products[index].name} ₦${products[index].price}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Spacer(),
                              SmoothPageIndicator(
                                controller: _controller,
                                count: 4,
                                effect: WormEffect(
                                  dotWidth: 8,
                                  dotHeight: 8,
                                  spacing: 16,
                                  activeDotColor: Colors.white,
                                  dotColor: Colors.white.withOpacity(0.5),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 390,
                        height: 200,
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1,
                          ),
                          itemCount: avatars.length,
                          itemBuilder: (context, index) {
                            return avatars[index];
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Our Special Offers",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 390,
                      height: 1320,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
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
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 168,
                                height: 138,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 0.5, color: Colors.grey.shade300),
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
                                              .addToWishlist(product);
                                        },
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade400,
                                              borderRadius:
                                                  BorderRadius.circular(18)),
                                          child: const Icon(
                                            Icons.favorite_border_outlined,
                                            size: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                  Positioned(
                                    bottom: 0,
                                    right: 40,
                                    child: Image.network(
                                      product.imageUrl,
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                ]),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => Productsdetails(
                                        product: product,
                                        controller: bottomNavigationController,
                                        cartController: widget.cartController,
                                        allProducts: [],
                                      ));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'NGN ${product.price * 2}',
                                          style: TextStyle(
                                              color: Colors.grey.shade500,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                        const Spacer(),
                                        Container(
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
                                        const SizedBox(
                                          width: 10,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        bottomNavigationController.changePage(1);
                        Get.off(() => ProductsPage(
                              bottomNavigationController:
                                  bottomNavigationController,
                              cartController: widget.cartController,
                            ));
                      },
                      child: Center(
                        child: Container(
                          width: 70,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 2)),
                          child: Text(
                            "View all",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavBar(
        bottomNavigationController: bottomNavigationController,
        cartController: widget.cartController,
      ),
    );
  }
}
