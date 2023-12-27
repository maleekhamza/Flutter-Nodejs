import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../model/restaurant_model.dart';

class RestaurantItem extends StatelessWidget {
  final RestaurantModel? model;
  final Function? onDelete;

  RestaurantItem({
    Key? key,
    this.model,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: restaurantItem(context),
      ),
    );
  }

  Widget restaurantItem(context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(
                  (model!.restaurantImage == null || model!.restaurantImage == "")
                      ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
                      : model!.restaurantImage!,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Restaurant Name:',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  model!.restaurantName!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Price:',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "${model!.restaurantPrice}Dt",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: const Icon(Icons.edit),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/edit-restaurant',
                          arguments: {
                            'model': model,
                          },
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onTap: () {
                        onDelete!(model);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}