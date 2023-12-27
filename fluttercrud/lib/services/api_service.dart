import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../config.dart';
import '../model/restaurant_model.dart';

class APIService {
  static var client = http.Client();

  static Future<List<RestaurantModel>?> getRestaurants() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.restaurantsAPI, // Assuming you have a restaurantsAPI in your Config class
    );

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return restaurantsFromJson(data["data"]); // Assuming you have a restaurantsFromJson function

    } else {
      return null;
    }
  }

  static Future<bool> saveRestaurant(
      RestaurantModel model,
      bool isEditMode,
      bool isFileSelected,
      ) async {
    var restaurantURL = Config.restaurantsAPI; // Assuming you have a restaurantsAPI in your Config class

    if (isEditMode) {
      restaurantURL = restaurantURL + "/" + model.id.toString();
    }

    var url = Uri.http(Config.apiURL, restaurantURL);

    var requestMethod = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["restaurantName"] = model.restaurantName!; // Assuming you have a restaurantName field
    request.fields["restaurantPrice"] = model.restaurantPrice!.toString(); // Assuming you have a restaurantPrice field

    if (model.restaurantImage != null && isFileSelected) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'restaurantImage', // Assuming you have a restaurantImage field
        model.restaurantImage!,
      );

      request.files.add(multipartFile);
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteRestaurant(restaurantId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.restaurantsAPI + "/" + restaurantId.toString(), // Assuming you have a restaurantsAPI in your Config class
    );

    var response = await client.delete(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}