import 'package:get/get.dart';

import '../cart.dart';
import '../homepage.dart';

class BottomNavigationController extends GetxController {
  var currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
}
