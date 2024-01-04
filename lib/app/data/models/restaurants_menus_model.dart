class RestaurantsMenus {
  int? id;
  int? userId;
  String? restaurantName;
  String? appetizer;
  String? mainCourse;
  String? dessert;
  String? beverages;
  bool? wantsBread; 
  String? price;
  String? restaurantImageUrl;
  String? restaurantMenuImageUrl;
  String? createdAt;

  RestaurantsMenus({
    required this.id,
    required this.userId,
    required this.restaurantName,
    required this.appetizer,
    required this.mainCourse,
    required this.dessert,
    required this.beverages,
    required this.wantsBread,
    required this.price,
    required this.restaurantImageUrl,
    required this.restaurantMenuImageUrl,
    required this.createdAt
  });

  RestaurantsMenus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    restaurantName = json['restaurant_name'];
    appetizer = json['appetizer'];
    mainCourse = json['main_course'];
    dessert = json['dessert'];
    beverages = json['beverages'];
    wantsBread = json['wants_bread'];
    price = json['price'];
    restaurantImageUrl = json['restaurant_image_url'];
    restaurantMenuImageUrl = json['restaurant_menu_image_url'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['restaurant_name'] = restaurantName;
    data['appetizer'] = appetizer;
    data['main_course'] = mainCourse;
    data['dessert'] = dessert;
    data['beverages'] = beverages;
    data['wants_bread'] = wantsBread;
    data['price'] = price;
    data['restaurant_image_url'] = restaurantImageUrl;
    data['restaurant_menu_image_url'] = restaurantMenuImageUrl;
    data['created_at'] = createdAt;
    return data;
  }

  static List<RestaurantsMenus> fromJsonList(List? data) {
    if (data == null || data.isEmpty) return [];
    return data.map((e) => RestaurantsMenus.fromJson(e)).toList();
  }
}
