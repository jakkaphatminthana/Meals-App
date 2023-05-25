import 'package:flutter/material.dart';
import 'package:flutter_meals/fetures/category/data/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onSelectCategory,
  });

  final Category category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectCategory,  //click to...
      splashColor: Theme.of(context).primaryColor, //Ef.กดแล้วมีสีออกมา
      borderRadius: BorderRadius.circular(16), //Ef.กดแล้วขอบจะมน
      child: Container(
        padding: const EdgeInsets.all(16),
        //TODO 1: Style Color Card
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        //TODO 2: Text title
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
