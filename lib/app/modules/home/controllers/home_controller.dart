// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_example/app/data/models/restaurants_menus_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  RxList allRestaurantsMenus = List<RestaurantsMenus>.empty().obs;
  TextEditingController searchRestaurantName = TextEditingController();
  SupabaseClient client = Supabase.instance.client;

  Future<void> getAllRestaurantsMenus() async {
    List<dynamic> res = await client
        .from("users")
        .select("id")
        .match({"uid": client.auth.currentUser!.id});
    Map<String, dynamic> user = (res).first as Map<String, dynamic>;
    int id = user["id"];
    var restaurantMenus = await client.from("restaurants_menus").select().match(
      {"user_id": id},
    );
    List<RestaurantsMenus> restaurantMenusData = RestaurantsMenus.fromJsonList((restaurantMenus as List));
    allRestaurantsMenus(restaurantMenusData);
    allRestaurantsMenus.refresh();
  }

  Future<void> deleteRestaurantMenu(int id) async {
    await client.from("restaurants_menus").delete().match({
      "id": id,
    });
    getAllRestaurantsMenus();
    searchRestaurantName.clear();
  }

  Future<void> searchRestaurants(String name) async {
    List<dynamic> res = await client
        .from("users")
        .select("id")
        .match({"uid": client.auth.currentUser!.id});
    Map<String, dynamic> user = (res).first as Map<String, dynamic>;
    int id = user["id"];

    final response = await client
        .from("restaurants_menus")
        .select()
        .match({"user_id": id})
        .textSearch('restaurant_name_vector', '%$name%')
        .execute();

    if (response.data != null) {
      List<RestaurantsMenus> restaurantMenusData = RestaurantsMenus.fromJsonList(response.data as List);
      allRestaurantsMenus(restaurantMenusData);
      allRestaurantsMenus.refresh();
    } else {
      Get.snackbar("ERROR", "No matching restaurants found");
    }
  }
}
