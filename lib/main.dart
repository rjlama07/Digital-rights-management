import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nepalihiphub/view/splash_screen.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('localData');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(foregroundColor: Colors.black),
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
