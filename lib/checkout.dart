import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'success.dart';

class CheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> checkoutList;
  const CheckoutPage({super.key, required this.checkoutList});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  int selectedValue = 1;
  final isButtonEnabled = true.obs;
  double delivery = 1500.00;

  void _validateForm() {
    isButtonEnabled.value = nameController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        numberController.text.isNotEmpty;
  }

  void payment() {
    if (nameController.text.isEmpty ||
        addressController.text.isEmpty ||
        numberController.text.isEmpty) {
      Get.snackbar('Error', 'All fields are required',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    Get.to(() => PaymentSuccessPage());
  }

  void handleRadioValueChange(int? value) {
    setState(() {
      selectedValue = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0.0;
    for (var item in widget.checkoutList) {
      totalPrice += item['quantity'] * item['price'];
    }

    double total = totalPrice + delivery;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CheckOut",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text("Order List",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                const Spacer(),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Edit",
                      style: TextStyle(color: Colors.blue.shade700),
                    ))
              ],
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: widget.checkoutList.length,
                    itemBuilder: (context, index) {
                      final item = widget.checkoutList[index];
                      final product_image = item['product image'];
                      final product = item['product'];
                      final size = item['size'];
                      final color = item['color'];
                      var quantity = item['quantity'];
                      double price = item['price'];
                      return ListTile(
                          leading: Image.network(
                            product_image,
                            width: 100,
                            height: 120,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error);
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
                                    const Text("Quantity"),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: Colors.blue.shade100),
                                      child: Text(
                                        "${quantity}",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Text('| ${price.toStringAsFixed(2)}'),
                                  ],
                                )
                              ]));
                    })),
            SizedBox(
              width: 358,
              height: 104,
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text("Personal Information",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      Spacer(),
                      Text(
                        "Edit",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/contacts.png",
                              width: 16,
                              height: 16,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text("Ada Dennis"),
                            const Spacer(),
                            Image.asset(
                              "assets/smartphone.png",
                              width: 16,
                              height: 16,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text("091000000000")
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/email.png",
                              width: 16,
                              height: 16,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text("ad@gmail.com"),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 358,
              height: 78,
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text("Delivery Option",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      Spacer(),
                      Text(
                        "Edit",
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/pickup.png",
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text("Ikeja, Lagos")
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 358,
              height: 190,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Price Summary",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text("Total Price"),
                            const Spacer(),
                            Text('₦     ${totalPrice}')
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Delivery Fee"),
                            const Spacer(),
                            Text("₦       ${delivery}")
                          ],
                        ),
                        const Row(
                          children: [Text("Discount"), Spacer(), Text("0.00")],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text("Total Price"),
                            const Spacer(),
                            Text('₦     $total')
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(
                  width: 89,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontSize: 10),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                        side: const BorderSide(style: BorderStyle.none)),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: 89,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              width: 390,
                              height: 538,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("Select a payment option"),
                                        Spacer(),
                                        IconButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            icon: Icon(Icons.cancel))
                                      ],
                                    ),
                                    ListTile(
                                      leading: Image.asset(
                                        "assets/payment.png",
                                        width: 46,
                                        height: 32,
                                      ),
                                      title: Text("**** **** **** 1234"),
                                      subtitle: Text("05/24"),
                                      trailing: Radio(
                                        activeColor: Colors.blue,
                                        value: 1,
                                        groupValue: selectedValue,
                                        onChanged: handleRadioValueChange,
                                      ),
                                      onTap: () {
                                        if (selectedValue != 1) {
                                          handleRadioValueChange(1);
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Full Name"),
                                                SizedBox(
                                                  width: 350,
                                                  height: 46,
                                                  child: TextFormField(
                                                    controller: nameController,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "Enter your Name",
                                                        hintStyle: TextStyle(
                                                            color: Colors
                                                                .grey.shade400,
                                                            fontFamily:
                                                                "Poppins-Italic",
                                                            fontStyle: FontStyle
                                                                .italic),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                width: 0.5,
                                                                color: Colors
                                                                    .black),
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        12))),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                width: 1,
                                                                color: Colors
                                                                    .grey
                                                                    .shade300),
                                                            borderRadius: BorderRadius.all(Radius.circular(12)))),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Email address"),
                                                SizedBox(
                                                  width: 350,
                                                  height: 46,
                                                  child: TextFormField(
                                                    controller:
                                                        addressController,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "Enter your Email address",
                                                        hintStyle: TextStyle(
                                                            color: Colors
                                                                .grey.shade400,
                                                            fontFamily:
                                                                "Poppins-Italic",
                                                            fontStyle: FontStyle
                                                                .italic),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                width: 0.5,
                                                                color: Colors
                                                                    .black),
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        12))),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                width: 1,
                                                                color: Colors
                                                                    .grey
                                                                    .shade300),
                                                            borderRadius: BorderRadius.all(Radius.circular(12)))),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Phone Number"),
                                                SizedBox(
                                                  width: 350,
                                                  height: 46,
                                                  child: TextFormField(
                                                    controller:
                                                        numberController,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "Enter your Number",
                                                        hintStyle: TextStyle(
                                                            color: Colors
                                                                .grey.shade400,
                                                            fontFamily:
                                                                "Poppins-Italic",
                                                            fontStyle: FontStyle
                                                                .italic),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                width: 0.5,
                                                                color: Colors
                                                                    .black),
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        12))),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                width: 1,
                                                                color: Colors
                                                                    .grey
                                                                    .shade300),
                                                            borderRadius: BorderRadius.all(Radius.circular(12)))),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Obx(() => SizedBox(
                                                  width: 350,
                                                  height: 42,
                                                  child: ElevatedButton(
                                                    onPressed:
                                                        isButtonEnabled.value
                                                            ? payment
                                                            : null,
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.blue.shade700,
                                                    ),
                                                    child: Text(
                                                      'Pay',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: const Text(
                      "Proceed",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        side: const BorderSide(style: BorderStyle.none)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
