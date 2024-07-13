import 'package:get/get.dart';

class CartController extends GetxController {
  var checkoutItems = <Map<String, dynamic>>[].obs;

  void addItem(Map<String, dynamic> item) {
    checkoutItems.add(item);
  }

  void removeItem(int index) {
    checkoutItems.removeAt(index);
  }

  void incrementQuantity(int index) {
    checkoutItems[index]['quantity']++;
    checkoutItems.refresh(); // Refresh to update UI
  }

  void decrementQuantity(int index) {
    if (checkoutItems[index]['quantity'] > 0) {
      checkoutItems[index]['quantity']--;
      checkoutItems.refresh(); // Refresh to update UI
    }
  }
}
