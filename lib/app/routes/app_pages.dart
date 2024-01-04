// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import 'package:supabase_example/app/modules/add_restaurant_menu/bindings/add_restaurant_menu_binding.dart';
import 'package:supabase_example/app/modules/add_restaurant_menu/views/add_restaurant_menu_view.dart';
import 'package:supabase_example/app/modules/edit_restaurant_menu/bindings/edit_restaurant_menu_binding.dart';
import 'package:supabase_example/app/modules/edit_restaurant_menu/views/edit_restaurant_menu_view.dart';
import 'package:supabase_example/app/modules/home/bindings/home_binding.dart';
import 'package:supabase_example/app/modules/home/views/home_view.dart';
import 'package:supabase_example/app/modules/login/bindings/login_binding.dart';
import 'package:supabase_example/app/modules/login/views/login_view.dart';
import 'package:supabase_example/app/modules/profile/bindings/profile_binding.dart';
import 'package:supabase_example/app/modules/profile/views/profile_view.dart';
import 'package:supabase_example/app/modules/register/bindings/register_binding.dart';
import 'package:supabase_example/app/modules/register/views/register_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ADD_RESTAURANT_MENU,
      page: () => AddRestaurantMenuView(),
      binding: AddRestaurantMenuBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_RESTAURANT_MENU,
      page: () => EditRestaurantMenuView(),
      binding: EditRestaurantMenuBinding(),
    ),
  ];
}
