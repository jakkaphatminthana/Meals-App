import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  //data starter
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  //?Change state (คุณสมบัติของ Map คือถ้า add ข้อมูลใหม่ที่มีชื่อเหมือนกับของเก่า = update ค่าใหม่แทน)

  //TODO : Set Filter (แบบทั้งหมด)
  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  //TODO : Set Filter (แบบทีละอัน)
  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

//======================================================================================================================
//TODO
final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());
