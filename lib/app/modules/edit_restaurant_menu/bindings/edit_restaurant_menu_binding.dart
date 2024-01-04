import 'package:get/get.dart';

import '../controllers/edit_restaurant_menu_controller.dart';

class EditRestaurantMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditRestaurantMenuController>(
      () => EditRestaurantMenuController(),
    );
  }
}
