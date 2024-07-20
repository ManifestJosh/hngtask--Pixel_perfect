import 'package:get/get.dart';

class CartController extends GetxController {
  var Items = <Map<String, dynamic>>[].obs;
  var totalPrice = 0.0.obs;

  void addItem(Map<String, dynamic> item) {
    Items.add(item);
    updateTotalPrice();
  }

  void removeItem(int index) {
    if (index >= 0 && index < Items.length) {
      Items.removeAt(index);
      updateTotalPrice();
    }
  }

  void incrementQuantity(int index) {
    if (index >= 0 && index < Items.length) {
      Items[index]['quantity'] += 1;
      updateTotalPrice();
    }
  }

  void decrementQuantity(int index) {
    if (index >= 0 && index < Items.length) {
      if (Items[index]['quantity'] > 1) {
        Items[index]['quantity'] -= 1;
      } else {
        removeItem(index);
      }
      updateTotalPrice();
    }
  }

  void updateTotalPrice() {
    double total = 0.0;
    for (var item in Items) {
      total += item['quantity'] * item['price'];
    }
    totalPrice.value = total;
  }
}
