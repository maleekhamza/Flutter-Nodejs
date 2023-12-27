import 'package:flutter/material.dart';

import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../model/restaurant_model.dart';
import '../services/api_service.dart';
import 'Restaurant_Item.dart';

class RestaurantsList extends StatefulWidget {
  const RestaurantsList({Key? key}) : super(key: key);

  @override
  _RestaurantsListState createState() => _RestaurantsListState();
}

class _RestaurantsListState extends State<RestaurantsList> {
  bool isApiCallProcess = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page', style: TextStyle(color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.white, // Set the background color to white
        iconTheme: IconThemeData(color: Colors.black), // Set the icon color to black
      ),
      backgroundColor: Colors.grey[200],
      body: ProgressHUD(
        child: loadRestaurants(),
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
      ),
      // Set the floating action button at the bottom right
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/add-restaurant',
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget loadRestaurants() {
    return FutureBuilder(
      future: APIService.getRestaurants(),
      builder: (
          BuildContext context,
          AsyncSnapshot<List<RestaurantModel>?> model,
          ) {
        if (model.hasData) {
          return restaurantList(model.data);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget restaurantList(restaurants) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Replace ElevatedButton with FloatingActionButton

              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  return RestaurantItem(
                    model: restaurants[index],
                    onDelete: (RestaurantModel model) {
                      setState(() {
                        isApiCallProcess = true;
                      });

                      APIService.deleteRestaurant(model.id).then(
                            (response) {
                          setState(() {
                            isApiCallProcess = false;
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}