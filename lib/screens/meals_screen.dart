import 'package:app04/widgets/meal_iteam.dart';
import 'package:flutter/material.dart';
import '../models/meal.dart';
// import '../widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meals, required List meal});

  final String title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    Widget content = meals.isEmpty
        ? const Center(child: Text('No meals found...'))
        : ListView.builder(
            itemCount: meals.length,
            itemBuilder: (ctx, index) => MealItem(meal: meals[index]),
          );

    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: Colors.blue),
      body: content,
    );
  }
}
