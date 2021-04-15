import 'package:flutter/material.dart';
import 'package:meal_recipes/category_item.dart';
import 'package:meal_recipes/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DeliMeal'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(25),
        children: DUMMY_CATEGORIES
            .map((categoryData) => CategoryItem(
                categoryData.id, categoryData.title, categoryData.color))
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          // 200 width, it will be 300 height
          crossAxisSpacing: 20, mainAxisSpacing: 20,
        ),
      ),
    );
  }
}
