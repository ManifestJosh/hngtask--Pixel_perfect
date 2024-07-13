import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixel_perfect/checkout.dart';
import 'package:pixel_perfect/controller/bottomnav.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> checkoutItems;

  const CartPage({
    super.key,
    required this.checkoutItems,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late BottomNavigationController controller;
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    controller = Get.put(BottomNavigationController());

    // Print statement for debugging
    print("Checkout items on CartPage init: ${widget.checkoutItems}");
  }

  void _incrementCounter(int index) {
    setState(() {
      widget.checkoutItems[index]['quantity']++;
      _calculateTotalPrice();
    });
  }

  void _decrementCounter(int index) {
    setState(() {
      if (widget.checkoutItems[index]['quantity'] > 0) {
        widget.checkoutItems[index]['quantity']--;
        _calculateTotalPrice();
      }
    });
  }

  void _calculateTotalPrice() {
    double total = 0.0;
    for (var item in widget.checkoutItems) {
      total += item['quantity'] * item['price'];
    }
    setState(() {
      totalPrice = total;
    });
  }

  void _addToCheckout() {
    List<Map<String, dynamic>> checkoutList = [];

    // Add all items from widget.checkoutItems to checkoutList
    checkoutList.addAll(widget.checkoutItems);

    // Navigate to CheckoutPage and pass checkoutList
    Get.to(() => CheckoutPage(checkoutList: checkoutList));
  }

  @override
  Widget build(BuildContext context) {
    // Print statement for debugging
    print("Building CartPage with checkout items: ${widget.checkoutItems}");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: widget.checkoutItems.length,
                itemBuilder: (context, index) {
                  final item = widget.checkoutItems[index];
                  final product_image = item['product image'];
                  final product = item['product'];
                  final size = item['size'];
                  final color = item['color'];
                  var quantity = item['quantity'];
                  final price = item['price'];

                  return ListTile(
                    leading: Image.network(
                      product_image,
                      width: 100,
                      height: 120,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.error);
                      },
                    ),
                    title: Text(product),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Color: $color'),
                            Text(' | Size: $size'),
                          ],
                        ),
                        Row(
                          children: [
                            ClipRRect(
                              child: IconButton(
                                  icon: Icon(CupertinoIcons.minus),
                                  onPressed: () => _decrementCounter(index)),
                            ),
                            Container(
                                width: 20,
                                height: 20,
                                decoration:
                                    BoxDecoration(color: Colors.blue.shade50),
                                child: Text(
                                  '$quantity',
                                  textAlign: TextAlign.center,
                                )),
                            ClipRRect(
                              child: IconButton(
                                  icon: Icon(CupertinoIcons.add),
                                  onPressed: () => _incrementCounter(index)),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        Text(
                          "₦ $price",
                          style: TextStyle(color: Colors.blue.shade800),
                        )
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.cancel_outlined),
                      onPressed: () {
                        setState(() {
                          widget.checkoutItems.removeAt(index);
                        });
                      },
                    ),
                  );
                }),
          ),
          Row(
            children: [
              Column(
                children: [
                  Text("Total Price"),
                  Text(
                    "₦$totalPrice",
                    style: TextStyle(fontSize: 20, color: Colors.blue.shade800),
                  )
                ],
              ),
              Spacer(),
              GestureDetector(
                  onTap: _addToCheckout,
                  child: Container(
                      width: 141,
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: Colors.blue.shade800,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/cart.png",
                              color: Colors.white,
                              width: 14,
                              height: 14,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Checkout",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            )
                          ])))
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
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
                Get.offAllNamed(
                    '/home'); // replace with your home page route name
                break;
              case 1:
                Get.toNamed(
                    '/all-products'); // replace with your all products page route name
                break;
              case 2:
                Get.toNamed('/cart'); // replace with your cart page route name
                break;
              case 3:
                Get.toNamed(
                    '/my-order'); // replace with your my order page route name
                break;
              case 4:
                Get.toNamed(
                    '/profile'); // replace with your profile page route name
                break;
            }
          },
        ),
      ),
    );
  }
}
