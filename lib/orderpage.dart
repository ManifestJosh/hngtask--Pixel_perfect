import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixel_perfect/controller/bottomnav.dart';
import 'package:pixel_perfect/controller/cartcontroller.dart';

import 'controller/ordercontroller.dart';
import 'database/databasehelper.dart';
import 'orderdetails.dart';

class OrderHistoryPage extends StatefulWidget {
  final CartController cartController;
  final BottomNavigationController bottomNavigationController;

  OrderHistoryPage({
    super.key,
    required this.bottomNavigationController,
    required this.cartController,
  });

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  Future<List<Order>>? _orders;

  @override
  void initState() {
    super.initState();
    _orders = _dbHelper.getOrderHistory();
  }

  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<Order>>(
          future: _orders,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No orders found.'));
            }
            final orders = snapshot.data!;

            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            border: Border.all(color: Colors.blue)),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => Orderdetails(order: order));
                          },
                          child: ListTile(
                            title: Text(
                              'Order #${index + 1}',
                              style: TextStyle(
                                  color: Colors.blue.shade400,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Date: ${order.date.toLocal()}'), // Format the date as needed
                                Text(
                                  'Total Price: ₦ ${order.totalPrice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                ...order.items
                                    .map((item) => Text(
                                        'Product: ${item['product']},   Quantity: ${item['quantity']}'))
                                    .toList(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                );
              },
            );
          }),
      bottomNavigationBar: BottomNavBar(
        cartController: widget.cartController,
        bottomNavigationController: widget.bottomNavigationController,
      ),
    );
  }
}
