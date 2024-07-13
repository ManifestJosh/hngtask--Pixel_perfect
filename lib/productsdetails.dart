import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixel_perfect/Api.dart';
import 'package:pixel_perfect/cart.dart';
import 'package:pixel_perfect/controller/bottomnav.dart';

import 'homepage.dart';

class Productsdetails extends StatefulWidget {
  final BottomNavigationController controller;
  final Products product;
  const Productsdetails(
      {super.key, required this.product, required this.controller});

  @override
  State<Productsdetails> createState() => _ProductsdetailsState();
}

class _ProductsdetailsState extends State<Productsdetails> {
  List<Map<String, dynamic>> checkoutItems = [];
  int _counter = 0;
  List<bool> _isSelected = List.generate(7, (index) => false);
  List<bool> colorSelect = List.generate(7, (index) => false);

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) _counter--;
    });
  }

  void addtoCart() {
    setState(() {
      String selectedSize = "";
      String selectedColor = "";

      for (int i = 0; i < _isSelected.length; i++) {
        if (_isSelected[i]) {
          selectedSize = ["32", "35", "38", "39", "40", "42", "45"][i];
          break;
        }
      }

      for (int i = 0; i < colorSelect.length; i++) {
        if (colorSelect[i]) {
          selectedColor =
              ["Amber", "Blue", "Green", "Black", "Red", "Green", "Purple"][i];
          break;
        }
      }

      checkoutItems.add({
        'product': widget.product.name,
        'product image': widget.product.imageUrl,
        'size': selectedSize,
        'color': selectedColor,
        'quantity': _counter,
        'price': widget.product.price
      });

      // Print statement to debug
      print('Added to checkout:');
      print('Product: ${widget.product.name}');
      print('Size: $selectedSize');
      print('Color: $selectedColor');
      print('Quantity: $_counter');
      print('Price: ${widget.product.price}');
      print('Current checkout items: $checkoutItems');

      Get.to(() => CartPage(
            checkoutItems: checkoutItems,
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  width: 250,
                  height: 250,
                  child: Image.network(
                    widget.product.imageUrl,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Iconic Casual Brands"),
              Text(
                widget.product.name,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                'NGN ${widget.product.price}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text('100 sold '),
                  SizedBox(
                    width: 20,
                  ),
                  Image.asset(
                    "assets/rate.png",
                    width: 10,
                    height: 10,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('4.5 (32 Reviews)'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Description",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(widget.product.description),
              SizedBox(
                height: 20,
              ),
              Text(
                "Size:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ToggleButtons(
                selectedColor: Colors.white,
                fillColor: Colors.blue,
                children: [
                  Text("32"),
                  Text("35"),
                  Text("38"),
                  Text("39"),
                  Text("40"),
                  Text("42"),
                  Text("45")
                ],
                isSelected: _isSelected,
                onPressed: (index) {
                  setState(() {
                    for (int i = 0; i < _isSelected.length; i++) {
                      _isSelected[i] = i == index;
                    }
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Colors",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ToggleButtons(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(color: Colors.amber),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(color: Colors.blue),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(color: Colors.green),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(color: Colors.black),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(color: Colors.red),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(color: Colors.green),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(color: Colors.purple),
                  )
                ],
                isSelected: colorSelect,
                onPressed: (index) {
                  setState(() {
                    for (int i = 0; i < colorSelect.length; i++) {
                      colorSelect[i] = i == index;
                    }
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Quantity",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  ClipRRect(
                    child: IconButton(
                        icon: Icon(CupertinoIcons.minus),
                        onPressed: _decrementCounter),
                  ),
                  Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(color: Colors.blue.shade50),
                      child: Text(
                        '$_counter',
                        textAlign: TextAlign.center,
                      )),
                  ClipRRect(
                    child: IconButton(
                        icon: Icon(CupertinoIcons.add),
                        onPressed: _incrementCounter),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "More from ${widget.product.name}",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 390,
                height: 612,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 350,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final product = widget.product;
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => Productsdetails(
                              product: product,
                              controller: widget.controller,
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
                          Row(
                            children: [
                              Text(
                                'NGN ${product.price * 2}',
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    decoration: TextDecoration.lineThrough),
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
              Text("Total Price:"),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "₦${widget.product.price}",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: addtoCart,
                    child: Container(
                      width: 141,
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: Colors.blue,
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
                            "Add to Cart",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
