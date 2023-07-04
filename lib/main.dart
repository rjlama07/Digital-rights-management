import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:nepalihiphub/constant/app_colors.dart';
import 'package:nepalihiphub/constant/text.dart';
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
    return KhaltiScope(
        enabledDebugging: true,
        publicKey: "test_public_key_af81192c8ca44e90a974d4a86453bb89",
        builder: (context, navKey) {
          return ScreenUtilInit(
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return GetMaterialApp(
                  themeMode: ThemeMode.dark,
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  darkTheme: ThemeData.dark().copyWith(
                      inputDecorationTheme: InputDecorationTheme(
                          hintStyle: darkTextTheme.labelMedium,
                          iconColor: white,
                          prefixIconColor: white),
                      scaffoldBackgroundColor: backgroundColor,
                      textTheme: darkTextTheme),
                  home: const SplashScreen(),
                  navigatorKey: navKey,
                  localizationsDelegates: const [KhaltiLocalizations.delegate],
                );
              });
        });
  }
}
