import 'package:get/get.dart';

import '../cart.dart';
import '../homepage.dart';

class BottomNavigationController extends GetxController {
  var currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
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
  }
}
