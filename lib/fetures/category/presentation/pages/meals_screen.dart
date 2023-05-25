import 'package:flutter/material.dart';
import 'package:flutter_meals/fetures/category/data/models/meal.dart';
import 'package:flutter_meals/fetures/category/presentation/pages/meal_detail_screen.dart';

import '../widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;

  //go to MealDetail page
  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailScreen(
          meal: meal,
        ),
      ),
    );
  }

//=========================================================================================================================
  @override
  Widget build(BuildContext context) {
    //TODO : Content List <Meals Item>
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) {
        // final meal = meals[index];

        return MealItem(
          meal: meals[index],
          onSelectMeal: selectMeal,
        );
      },
    );

    //TODO : IsEmpty Meals
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //title Text
            Text(
              'Uh oh ... nothing here!',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(height: 16),
            //subtitle Text
            Text(
              'Try selecting a different category!',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
      );
    }

    //======================================================================================================================
    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? ''),
      ),
      body: content,
    );
  }
}
