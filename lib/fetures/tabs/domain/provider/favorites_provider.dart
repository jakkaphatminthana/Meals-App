import 'package:flutter_meals/fetures/category/data/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]); //data starter

  //TODO : Click Favorite
  //มีการ return ค่าเพื่อนำไปใช้ร่วมกับ Snackbar 
  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    //Remove meal
    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
      //Add meal
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

//==========================================================================================
//TODO : Provider
final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
        (ref) => FavoriteMealsNotifier());
