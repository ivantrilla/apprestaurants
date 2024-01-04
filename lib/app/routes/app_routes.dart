// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const REGISTER = _Paths.REGISTER;
  static const PROFILE = _Paths.PROFILE;
  static const ADD_RESTAURANT_MENU = _Paths.ADD_RESTAURANT_MENU;
  static const EDIT_RESTAURANT_MENU = _Paths.EDIT_RESTAURANT_MENU;
}

abstract class _Paths {
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const PROFILE = '/profile';
  static const ADD_RESTAURANT_MENU = '/add-restaurant-menu';
  static const EDIT_RESTAURANT_MENU = '/edit-restaurant-menu';
}
