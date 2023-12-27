import 'package:flutter/material.dart';
import 'package:fluttercrud/pages/Restaurant_add_edit.dart';
import 'package:fluttercrud/pages/product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
    '/': (context) => const RestaurantsList(),
    '/add-restaurant': (context) => const RestaurantAddEdit(),
    '/edit-restaurant': (context) => const RestaurantAddEdit(),

      },
    );
  }
}
