import 'package:flutter/material.dart';
import 'package:flutter_meals/fetures/category/presentation/pages/categories_screen.dart';
import 'package:flutter_meals/fetures/category/presentation/pages/meals_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/provider/favorites_provider.dart';
import '../../domain/provider/filter_meals_provider.dart';
import '../../domain/provider/filter_provider.dart';
import '../widgets/main_draw.dart';
import 'filter_screen.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  //index page
  int _selectedPageIndex = 0;

  //TODO 1: Select page
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  //TODO 2: SetScreen on Drawer
  void _setScreen(String identifier) async {
    Navigator.of(context).pop(); //meals page
    if (identifier == 'filters') {
      //1. ไปหน้า filter และรอการรับค่าที่ส่งกลับมาเมื่อ pop
      //2. await เพื่อรอรับข้อมูล ซึ่งมีลักษณะแบบ Enum แบบว่าประมาณนี้ Map<Filter, bool>
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  //====================================================================================================================================

  @override
  Widget build(BuildContext context) {
    //Meal data ที่ทำการ filter ประเภทอาหารมาให้แล้ว
    final availableMeals = ref.watch(filteredMealsProvider);

    //TODO 1.1: ค่าเริ่มต้น index 0 = CategoriesScreen
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    ); //page screen
    var activePageTitle = 'Categories';

    //TODO 1.2: หากกดเลือก index 1 = Favorite Meals
    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: ref.watch(favoriteMealsProvider),
      );
      activePageTitle = 'Your Favorites';
    }

    //----------------------------------------------------------------------------------------------------------------
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage, //หน้าจอ
      //TODO : Slide Bar menu
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      //TODO : TabView
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
