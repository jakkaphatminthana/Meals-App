import 'package:flutter/material.dart';
import 'package:flutter_meals/fetures/category/data/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../tabs/domain/provider/favorites_provider.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider); //list data favorite
    final bool isFavorite = favoriteMeals.contains(meal); //check

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              //TODO : Event Action by Provider
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);

              //TODO : Massage Bar
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    wasAdded ? 'Meal added as a favorite' : 'Meal removed',
                  ),
                ),
              );
            },
            //TODO : Animation
            //สั่งเริ่ม animation จากการปรับเปลี่ยน widget
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                //animation หมุนๆ
                return RotationTransition(
                  //กำหนดเวลาเล่น
                  turns: Tween<double>(begin: 0.6, end: 1).animate(animation),
                  child: child,
                );
              },
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                key: ValueKey(isFavorite),
              ),
            ),
          ), 
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //TODO 1: Image
            //Hero = การสร้างอนิเมชันแบบต่อเนื่อง ระหว่างการเปลี่ยนหน้า
            Hero(
              //ทำให้สามารถรู้จักและจับคู่ Hero ให้ตรงกันระหว่างหน้าต้นฉบับและหน้าปลายทาง
              //!ต้องมี Hero ทั้งคู่
              tag: meal.id,
              child: Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 14),

            //TODO 2.1: รายการวัตถุดิบ title
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary, //ส้ม
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),

            //TODO 2.2: รายการวัตถุดิบ list
            //เอาข้อมลจาก meal.ingredients มาลูปลง ingredient
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground, //ขาว
                    ),
              ),
            const SizedBox(height: 24),

            //TODO 3.1 ขั้นตอนการทำ title
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary, //ส้ม
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),

            //TODO 3.2 ขั้นตอนการทำ list
            for (final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground, //ขาว
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
