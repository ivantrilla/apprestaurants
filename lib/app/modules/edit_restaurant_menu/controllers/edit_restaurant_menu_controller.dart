import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditRestaurantMenuController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  TextEditingController restaurantNameC = TextEditingController();
  TextEditingController appetizerC = TextEditingController();
  TextEditingController mainCourseC = TextEditingController();
  TextEditingController dessertC = TextEditingController();
  TextEditingController beveragesC = TextEditingController();
  RxBool wantsBread = false.obs;
  TextEditingController priceC = TextEditingController();
  TextEditingController searchRestaurantName = TextEditingController();
  SupabaseClient client = Supabase.instance.client;

  static final Set<String> defaultRestaurantNames = {
    "Bokoto", "Botafumeiro", "Braseria", "Colomi", "Dolceta", "Giraldillo", "Goiko", 
    "KFC", "Kebab", "McDonald's", "Subway", "Tagliatella", "Telepizza", "Timesburg" 
  };

  Future<bool> editRestaurantMenu(int id) async {
    if (restaurantNameC.text.isNotEmpty &&
        appetizerC.text.isNotEmpty &&
        mainCourseC.text.isNotEmpty &&
        dessertC.text.isNotEmpty &&
        beveragesC.text.isNotEmpty &&
        priceC.text.isNotEmpty) {
      isLoading.value = true;

      String restaurantImageUrl = defaultRestaurantNames.contains(restaurantNameC.text)
          ? 'https://mjycgirnllrnvftccopz.supabase.co/storage/v1/object/public/restaurants_images/restaurant_${restaurantNameC.text}.png'
          : 'https://mjycgirnllrnvftccopz.supabase.co/storage/v1/object/public/restaurants_images/restaurant_default.png';
      
      String restaurantMenuImageUrl = defaultRestaurantNames.contains(restaurantNameC.text)
          ? 'https://mjycgirnllrnvftccopz.supabase.co/storage/v1/object/public/restaurants_menus/restaurant_menu_${restaurantNameC.text}.png'
          : 'https://mjycgirnllrnvftccopz.supabase.co/storage/v1/object/public/restaurants_menus/restaurant_menu_default.png';

      await client.from("restaurants_menus").update({
        "restaurant_name": restaurantNameC.text,
        "appetizer": appetizerC.text,
        "main_course": mainCourseC.text,
        "dessert": dessertC.text,
        "beverages": beveragesC.text,
        "wants_bread": wantsBread.value,
        "price": priceC.text,
        "restaurant_image_url": restaurantImageUrl,
        "restaurant_menu_image_url": restaurantMenuImageUrl,
      }).match({
        "id": id,
      });
      return true;
    } else {
      return false;
    }
  }
}
