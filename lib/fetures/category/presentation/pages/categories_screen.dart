import 'package:flutter/material.dart';
import 'package:flutter_meals/fetures/category/data/database/dummy_category_data.dart';
import 'package:flutter_meals/fetures/category/data/models/category.dart';
import 'package:flutter_meals/fetures/category/data/models/meal.dart';
import 'package:flutter_meals/fetures/category/presentation/pages/meals_screen.dart';
import 'package:flutter_meals/fetures/category/presentation/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

//SingleTickerProviderStateMixin = มีหน้าที่ในการเรียกสั่งให้ Animation เปลี่ยนค่าตามเวลาที่กำหนด
class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  //Animation
  late AnimationController _animationController;

  //TODO : Function push category
  void _selectCategory(BuildContext context, Category category) {
    //1.1 filter Meals data ที่มี category.id ตรงกันใน availableMeals
    //1.2 ซึ่งค่าของ availableMeals เป็นข้อมูลที่ผ่านการกรอกเรื่อง ประเภทอาหาร มาให้แล้วอีกทีนึง
    //1.3 สรุปก็คือ *กรอก category.id ตรงกัน, *กรอกเรื่อง ประเภทอาหาร
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    //2. go to MealScreen (ชื่อประเภท, รายการอาหาร)
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    //สั่งให้ animation ทำงาน
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  //=========================================================================================================================
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //column
          childAspectRatio: 3 / 2, //อัตราส่วนหน้าจอ
          crossAxisSpacing: 20, //ระยะห่าง
          mainAxisSpacing: 20, //ระยะห่าง
        ),
        children: [
          //TODO : ดึงข้อมูล category data มาลูป
          //availableCategories.map((c) => CategoryGridItem(category: c)).toList
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () => _selectCategory(context, category),
            ),
        ],
      ),
      //TODO : Build Animation
      //สไลด์ จากแกน x, y -> จบที่แกน x, y
      builder: (context, child) => SlideTransition(
        //กำหนดตำแหน่ง เริ่ม-จบ
        position: Tween(
          begin: const Offset(0, 0.3), //Strat x,y
          end: const Offset(0, 0), //End x,y
        ).animate(
          //กำหนดโครงสร้างแกนเวลา (time axis) ของ Animation 
          CurvedAnimation(
            parent: _animationController, 
            curve: Curves.easeInOut, //กำหนดความเร่งของ Animation (easeInOut = ช้าๆ)
          ),
        ),
        child: child,
      ),
    );
  }
}
