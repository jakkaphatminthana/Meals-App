// ความซับซ้อน
enum Complexity {
  simple,
  challenging,
  hard,
}
// ระดับราคา
enum Affordability {
  affordable,
  pricey,
  luxurious,
}

class Meal {
  const Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });

  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients; //วัตถุดิบ
  final List<String> steps;
  final int duration; //ระยะเวลา
  final Complexity complexity; //ความซับซ้อน
  final Affordability affordability; //ระดับราคา
  final bool isGlutenFree;  //เป็นกลูเตน
  final bool isLactoseFree; //เป็นแลคโตส
  final bool isVegan; //เป็นวีแกน
  final bool isVegetarian; //เป็นมังสวิรัติ
}