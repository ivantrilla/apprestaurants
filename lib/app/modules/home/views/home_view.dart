// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_example/app/data/models/restaurants_menus_model.dart';
import 'package:supabase_example/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HOME',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 243, 173, 33),
        actions: [
          IconButton(
            onPressed: () async {
              Get.toNamed(Routes.PROFILE);
            },
            icon: const Icon(Icons.person),
          )
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 225, 255, 213),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (name) {
                controller.searchRestaurants(name);
              },
              controller: controller.searchRestaurantName,
              decoration: const InputDecoration(
                labelText: 'Search by Restaurant Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Obx(() => controller.allRestaurantsMenus.isEmpty
                ? const Center(
                    child: Text(
                      "NO DATA",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.allRestaurantsMenus.length,
                            itemBuilder: (context, index) {
                              RestaurantsMenus restaurantMenu = controller.allRestaurantsMenus[index];
                              return Card(
                                elevation: 3,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: InkWell(
                                  onTap: () => Get.toNamed(
                                    Routes.EDIT_RESTAURANT_MENU,
                                    arguments: restaurantMenu,
                                  ),
                                  child: ListTile(
                                    leading: Hero(
                                      tag: restaurantMenu.id!,
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                child: Container(
                                                  height: 200,
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                        restaurantMenu.restaurantImageUrl ??
                                                            'https://mjycgirnllrnvftccopz.supabase.co/storage/v1/object/public/restaurants_images/restaurant_default.png',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                restaurantMenu.restaurantImageUrl ??
                                                    'https://mjycgirnllrnvftccopz.supabase.co/storage/v1/object/public/restaurants_images/restaurant_default.png',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      restaurantMenu.restaurantName!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Appetizer: ${restaurantMenu.appetizer}"),
                                        Text("Main Course: ${restaurantMenu.mainCourse}"),
                                        Text("Dessert: ${restaurantMenu.dessert}"),
                                        Text("Beverages: ${restaurantMenu.beverages}"),
                                        if (restaurantMenu.wantsBread ?? false)
                                          const Row(
                                            children: [
                                              ImageIcon(
                                                AssetImage('assets/photos/bread.png'),
                                                size: 30,
                                              ),
                                            ],
                                          ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Price: ${restaurantMenu.price}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  child: Container(
                                                    height: 500,
                                                    width: 320,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                          restaurantMenu.restaurantMenuImageUrl ??
                                                              'https://mjycgirnllrnvftccopz.supabase.co/storage/v1/object/public/restaurants_menus/restaurant_menu_default.png',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          icon: const Icon(Icons.restaurant_menu),
                                        ),
                                        IconButton(
                                          onPressed: () async =>
                                              await controller.deleteRestaurantMenu(restaurantMenu.id!),
                                          icon: const Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_RESTAURANT_MENU),
        child: const Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 243, 173, 33),
      ),
    );
  }
}