List<RestaurantModel> restaurantsFromJson(dynamic str) =>
    List<RestaurantModel>.from((str).map((x) => RestaurantModel.fromJson(x)));
class RestaurantModel {
  late String? id;
  late String? restaurantName; // Assuming you have a restaurantName field
  late String? restaurantDescription; // Assuming you have a restaurantDescription field
  late int? restaurantPrice; // Assuming you have a restaurantPrice field
  late String? restaurantImage; // Assuming you have a restaurantImage field

  RestaurantModel({
    this.id,
    this.restaurantName,
    this.restaurantDescription,
    this.restaurantPrice,
    this.restaurantImage,
  });

  RestaurantModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    restaurantName = json['restaurantName'];
    restaurantDescription = json['restaurantDescription'];
    restaurantPrice = json['restaurantPrice'];
    restaurantImage = json['restaurantImage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['restaurantName'] = restaurantName;
    _data['restaurantDescription'] = restaurantDescription;
    _data['restaurantPrice'] = restaurantPrice;
    _data['restaurantImage'] = restaurantImage;
    return _data;
  }
}
