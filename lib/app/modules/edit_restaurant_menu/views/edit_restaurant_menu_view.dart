// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_example/app/data/models/restaurants_menus_model.dart';
import 'package:supabase_example/app/modules/home/controllers/home_controller.dart';

import '../controllers/edit_restaurant_menu_controller.dart';

class EditRestaurantMenuView extends GetView<EditRestaurantMenuController> {
  RestaurantsMenus restaurantMenu = Get.arguments;
  HomeController homeC = Get.find();

  EditRestaurantMenuView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.restaurantNameC.text = restaurantMenu.restaurantName!;
    controller.appetizerC.text = restaurantMenu.appetizer!;
    controller.mainCourseC.text = restaurantMenu.mainCourse!;
    controller.dessertC.text = restaurantMenu.dessert!;
    controller.beveragesC.text = restaurantMenu.beverages!;
    controller.wantsBread.value = restaurantMenu.wantsBread ?? false;
    controller.priceC.text = restaurantMenu.price!;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'EDIT RESTAURANT MENU',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 243, 173, 33),
        ),
        backgroundColor: const Color.fromARGB(255, 225, 255, 213),
        body: Obx(() => ListView(
              padding: const EdgeInsets.all(20),
              children: [
                TextField(
                  controller: controller.restaurantNameC,
                  decoration: const InputDecoration(
                    labelText: "Restaurant Name",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.store),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: controller.appetizerC,
                  decoration: const InputDecoration(
                    labelText: "Appetizer",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.fastfood),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: controller.mainCourseC,
                  decoration: const InputDecoration(
                    labelText: "Main Course",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.restaurant),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: controller.dessertC,
                  decoration: const InputDecoration(
                    labelText: "Dessert",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.icecream),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: controller.beveragesC,
                  decoration: const InputDecoration(
                    labelText: "Beverages",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.local_bar),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(right: 20),
                  leading: const ImageIcon(
                    AssetImage('assets/photos/bread.png'),
                    size: 35,
                  ),
                  title: const Text("Do You Want Bread?"),
                  trailing: Checkbox(
                    value: controller.wantsBread.value,
                    onChanged: (value) {
                      controller.wantsBread.value = value ?? false;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: controller.priceC,
                  decoration: const InputDecoration(
                    labelText: "Price",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => ElevatedButton(
                    onPressed: () async {
                      if (controller.isLoading.isFalse) {
                        bool res = await controller.editRestaurantMenu(restaurantMenu.id!);
                        if (res == true) {
                          await homeC.getAllRestaurantsMenus();
                          homeC.searchRestaurantName.clear();
                          Get.back();
                        }
                        controller.isLoading.value = false;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 243, 173, 33),
                    ),
                    child: Text(controller.isLoading.isFalse
                        ? "EDIT RESTAURANT MENU"
                        : "Loading...")))
              ],
            )));
  }
}
