import 'package:flutter/material.dart';

import 'controller/ordercontroller.dart';

class Orderdetails extends StatefulWidget {
  final Order order;
  const Orderdetails({super.key, required this.order});

  @override
  State<Orderdetails> createState() => _OrderdetailsState();
}

class _OrderdetailsState extends State<Orderdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Date: ${widget.order.date.toLocal()}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Total Price: ₦ ${widget.order.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Items:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView(
                children: widget.order.items.map((item) {
                  return ListTile(
                    title: Row(
                      children: [
                        Text(
                          'Product: ',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          '${item['product']}',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        )
                      ],
                    ),
                    subtitle: Text(
                      'Quantity: ${item['quantity']}',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
