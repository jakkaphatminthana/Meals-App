import 'package:flutter/material.dart';
import 'package:flutter_meals/resources/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'fetures/tabs/presentation/pages/tabs.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals App',
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: const TabsScreen(),
    );
  }
}
