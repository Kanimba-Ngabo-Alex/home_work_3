import 'package:home_work_3/dependency_injection.dart';
import 'package:home_work_3/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:home_work_3/pages/navbar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  DependecyInjection.init();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
