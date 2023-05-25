import 'package:flutter_meals/fetures/category/data/database/dummy_meal_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mealsProvider = Provider((ref) {
  return dummyMeals;
});
