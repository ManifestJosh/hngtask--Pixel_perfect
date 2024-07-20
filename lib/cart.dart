import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixel_perfect/checkout.dart';
import 'package:pixel_perfect/controller/bottomnav.dart';

import 'controller/cartcontroller.dart';

class CartPage extends StatefulWidget {
  final CartController cartController;
  final BottomNavigationController bottomNavigationController;
  CartPage({
    super.key,
    required this.cartController,
    required this.bottomNavigationController,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    double total = 0.0;
    for (var item in widget.cartController.Items) {
      total += item['quantity'] * item['price'];
    }
    setState(() {
      widget.cartController.totalPrice.value = total;
    });
  }

  void _addToCheckout() {
    List<Map<String, dynamic>> checkoutList = [];

    checkoutList.addAll(widget.cartController.Items);

    Get.to(() => CheckoutPage(checkoutList: checkoutList));
  }

  @override
  Widget build(BuildContext context) {
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
            child: Obx(() => ListView.builder(
                  itemCount: widget.cartController.Items.length,
                  itemBuilder: (context, index) {
                    final item = widget.cartController.Items[index];
                    final productImage = item['product image'];
                    final product = item['product'];
                    final size = item['size'];
                    final color = item['color'];
                    var quantity = item['quantity'];
                    final price = item['price'];

                    return ListTile(
                      leading: Image.network(
                        productImage,
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
                                  onPressed: () {
                                    widget.cartController
                                        .decrementQuantity(index);
                                    _calculateTotalPrice();
                                  },
                                ),
                              ),
                              Container(
                                width: 20,
                                height: 20,
                                decoration:
                                    BoxDecoration(color: Colors.blue.shade50),
                                child: Text(
                                  '$quantity',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              ClipRRect(
                                child: IconButton(
                                  icon: Icon(CupertinoIcons.add),
                                  onPressed: () {
                                    widget.cartController
                                        .incrementQuantity(index);
                                    _calculateTotalPrice();
                                  },
                                ),
                              ),
                              SizedBox(width: 20),
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
                          widget.cartController.removeItem(index);
                          _calculateTotalPrice();
                        },
                      ),
                    );
                  },
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Column(
                  children: [
                    Text("Total Price"),
                    Obx(() => Text(
                          "₦${widget.cartController.totalPrice.value}",
                          style: TextStyle(
                              fontSize: 20, color: Colors.blue.shade800),
                        )),
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
                        SizedBox(width: 10),
                        Text(
                          "Checkout",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        bottomNavigationController: widget.bottomNavigationController,
        cartController: widget.cartController,
      ),
    );
  }
}
