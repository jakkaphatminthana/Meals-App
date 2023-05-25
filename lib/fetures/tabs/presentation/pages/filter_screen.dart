import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/provider/filter_provider.dart';

class FiltersScreen extends ConsumerWidget {
  //HighLight <------------
  const FiltersScreen({super.key});

//TODO : Widget Switch
  SwitchListTile fliterSwitch({
    required BuildContext context,
    required bool value,
    required String title,
    required String subtitle,
    required Function(bool) onChange,
  }) {
    return SwitchListTile(
      value: value,
      onChanged: onChange,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 24),
    );
  }

  //========================================================================================================================
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      //TODO : กำหนดพฤติกรรมเมื่อ pop screen นี้
      body: Column(
        children: [
          //TODO 1: Switch Gluten
          fliterSwitch(
            context: context,
            value: activeFilters[Filter.glutenFree]!,
            title: 'Gluten-free',
            subtitle: 'Only include gluten-free meals.',
            onChange: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
            },
          ),

          //TODO 2: Switch Lactose
          fliterSwitch(
            context: context,
            value: activeFilters[Filter.lactoseFree]!,
            title: 'Lactose-free',
            subtitle: 'Only include lactose-free meals.',
            onChange: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
          ),

          //TODO 3: Switch Lactose
          fliterSwitch(
            context: context,
            value: activeFilters[Filter.vegetarian]!,
            title: 'Vegetarian-free',
            subtitle: 'Only include Vegetarian-free meals.',
            onChange: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
            },
          ),

          //TODO 4: Switch Lactose
          fliterSwitch(
            context: context,
            value: activeFilters[Filter.vegan]!,
            title: 'Vegan-free',
            subtitle: 'Only include Vegan-free meals.',
            onChange: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
          ),
        ],
      ),
    );
  }
}
