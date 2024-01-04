import 'package:get/get.dart';

import '../controllers/add_restaurant_menu_controller.dart';

class AddRestaurantMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddRestaurantMenuController>(
      () => AddRestaurantMenuController(),
    );
  }
}
