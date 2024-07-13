import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixel_perfect/Api.dart';

import 'package:pixel_perfect/controller/bottomnav.dart';
import 'package:pixel_perfect/productsdetails.dart';

import 'cart.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    super.key,
  });
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TimbuApi timbuApi = TimbuApi();
  late BottomNavigationController controller;

  @override
  void initState() {
    super.initState();
    controller = BottomNavigationController();
  }

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AG-Ezenard',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 390,
                      height: 80,
                      child: const Row(
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
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            gradient: LinearGradient(
                              colors: [Colors.blue, Colors.black],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 40,
                              ),
                              Image.network(
                                products[index].imageUrl,
                                width: 100,
                                height: 150,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Iconic Casual Brands",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 8)),
                                  Text(
                                    '${products[index].name} NGN ${products[index].price}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: 113,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/cart.png",
                                            width: 14,
                                            height: 14,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Add to Cart",
                                            style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 390,
                        height: 158,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey.shade200,
                                  child: Image.asset(
                                    "assets/nike.png",
                                    color: Colors.black,
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                                Text("Nike"),
                                SizedBox(
                                  height: 20,
                                ),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey.shade200,
                                  child: Image.asset(
                                    "assets/adidas.png",
                                    color: Colors.black,
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                                Text("Adidas"),
                              ],
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey.shade200,
                                  child: Image.asset(
                                    "assets/gucci.png",
                                    color: Colors.black,
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                                Text("Gucci"),
                                SizedBox(
                                  height: 20,
                                ),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey.shade200,
                                  child: Image.asset(
                                    "assets/reebok.png",
                                    color: Colors.black,
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                                Text("Reebok"),
                              ],
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey.shade200,
                                  child: Image.asset(
                                    "assets/jordan.png",
                                    color: Colors.black,
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                                Text("Jordan"),
                                SizedBox(
                                  height: 20,
                                ),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey.shade200,
                                  child: Image.asset(
                                    "assets/newbalance.png",
                                    color: Colors.black,
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                                Text("New Balance"),
                              ],
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey.shade200,
                                  child: Image.asset(
                                    "assets/balenciaga.png",
                                    color: Colors.black,
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                                Text("Balenciaga"),
                                SizedBox(
                                  height: 20,
                                ),
                                CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.grey.shade200,
                                    child: Text(
                                      "View All",
                                      style: TextStyle(fontSize: 8),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "Our Special Offers",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 390,
                      height: 1600,
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
                                    controller: controller,
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
                                        width: 0.5,
                                        color: Colors.grey.shade300),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(32)),
                                  ),
                                  child: Stack(children: [
                                    Positioned(
                                        top: 10,
                                        right: 10,
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade400,
                                              borderRadius:
                                                  BorderRadius.circular(18)),
                                          child: Icon(
                                            Icons.favorite_border_outlined,
                                            size: 18,
                                            color: Colors.white,
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
                                Text("Athletic/Sportswear"),
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
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
                                Row(
                                  children: [
                                    Text(
                                      'NGN ${product.price * 2}',
                                      style: TextStyle(
                                          color: Colors.grey.shade500,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                    Spacer(),
                                    Container(
                                        width: 36,
                                        height: 28,
                                        decoration: BoxDecoration(
                                            color: Colors.blue.shade100,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16))),
                                        child: Icon(
                                          CupertinoIcons.shopping_cart,
                                          size: 15,
                                          color: Colors.blue,
                                        )),
                                    SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),
                              ],
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
        },
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
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
          currentIndex: controller.currentIndex.value,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            controller.changePage(index);
            switch (index) {
              case 0:
                Get.off(() => Homepage());
                break;
              case 1:
                //Get.to(()=> Productspage());
                break;
              case 2:
                Get.to(() => CartPage(
                      checkoutItems: [],
                    ));
                break;
              case 3:
                //Get.to(()=> MyOrderPage());
                break;
              case 4:
                // Get.to(()=> ProfilePage());
                break;
            }
          },
        ),
      ),
    );
  }
}
