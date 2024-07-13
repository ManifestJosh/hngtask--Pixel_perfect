import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixel_perfect/homepage.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({super.key});

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/mark.png"),
            Text(
              "Payment Successful",
              style: TextStyle(fontSize: 18),
            ),
            Text(
                "You have successfully placed an order. Details of your order has been sent to your email. "),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 350,
              height: 42,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => Homepage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                ),
                child: Text(
                  'Pay',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
