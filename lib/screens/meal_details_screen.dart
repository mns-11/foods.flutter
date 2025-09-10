import 'package:app04/models/meal.dart';
import 'package:flutter/material.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(meal.title), backgroundColor: Colors.blue),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            _buildMealInfoRow(),
            _buildSectionTitle('Ingredients'),
            _buildIngredientsList(),
            _buildSectionTitle('Preparation Method'),
            _buildStepsList(),
            _buildSectionTitle('Nutritional Information'),
            _buildNutritionInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildMealInfoRow() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildInfoItem(Icons.access_time, '${meal.duration} min'),
          _buildInfoItem(Icons.work, _getComplexityText(meal.complexity)),
          _buildInfoItem(
            Icons.attach_money,
            _getAffordabilityText(meal.affordability),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, size: 24, color: Colors.blue),
        const SizedBox(height: 4),
        Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      color: Colors.blue[50],
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildIngredientsList() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: meal.ingredients.map((ingredient) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                const Icon(Icons.circle, size: 8, color: Colors.blue),
                const SizedBox(width: 12),
                Expanded(child: Text(ingredient)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStepsList() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: meal.steps.asMap().entries.map((entry) {
          final index = entry.key + 1;
          final step = entry.value;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      '$index',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(step)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNutritionInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          _buildNutritionChip('Gluten Free', meal.isGlutenFree),
          _buildNutritionChip('Vegetarian', meal.isVegetarian),
          _buildNutritionChip('Vegan', meal.isVegan),
          _buildNutritionChip('Lactose Free', meal.isLactoseFree),
        ],
      ),
    );
  }

  Widget _buildNutritionChip(String text, bool isTrue) {
    return Chip(
      label: Text(text),
      backgroundColor: isTrue ? Colors.green[100] : Colors.red[100],
      labelStyle: TextStyle(
        color: isTrue ? Colors.green[800] : Colors.red[800],
        fontWeight: FontWeight.bold,
      ),
    );
  }

  String _getComplexityText(Complexity complexity) {
    switch (complexity) {
      case Complexity.simple:
        return 'Easy';
      case Complexity.challenging:
        return 'Medium';
      case Complexity.hard:
        return 'Hard';
    }
  }

  String _getAffordabilityText(Affordability affordability) {
    switch (affordability) {
      case Affordability.affordable:
        return 'Affordable';
      case Affordability.pricey:
        return 'Pricey';
      case Affordability.luxurious:
        return 'Luxurious';
    }
  }
}
