import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class MealList extends StatelessWidget {
  final List<Meal> meals;

  const MealList(this.meals, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return MealItem(
          id: meals[index].id,
          title: meals[index].title,
          imageUrl: meals[index].imageUrl,
          duration: meals[index].duration,
          complexity: meals[index].complexity,
          affordability: meals[index].affordability,
        );
      },
      itemCount: meals.length,
    );
  }
}
