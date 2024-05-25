import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:nepalihiphub/constant/app_colors.dart';
import 'package:nepalihiphub/constant/text.dart';
import 'package:nepalihiphub/services/access_token_service.dart';
import 'package:nepalihiphub/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('localData');

  // AccessTokenService().deleteAccessToken();

  await JustAudioBackground.init(
    androidNotificationChannelName: 'Nepali Hip Hop',
    androidNotificationOngoing: true,
    androidNotificationChannelId: "com.nepalihiphop",
  );
  runApp(const MyApp());
}

Future<String> getLocalIPAddress() async {
  // Get the list of network interfaces
  var interfaces = await NetworkInterface.list();
  // Iterate over each interface
  for (var interface in interfaces) {
    // Iterate over each address in the interface
    for (var addr in interface.addresses) {
      // Check if the address is IPv4 and not loopback
      if (addr.type == InternetAddressType.IPv4 && !addr.isLoopback) {
        // Return the IP address
        return addr.address;
      }
    }
  }
  // Return null if no IPv4 address found
  return "";
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
                      elevatedButtonTheme: ElevatedButtonThemeData(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.maxFinite, 40),
                          backgroundColor: const Color(0xFFF0116F),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          foregroundColor: const Color(0xFF000000),
                          textStyle: darkTextTheme.labelMedium!.copyWith(
                              fontSize: 16.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                      inputDecorationTheme: InputDecorationTheme(
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          hintStyle: darkTextTheme.labelMedium,
                          labelStyle: darkTextTheme.labelMedium,
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

extension CapatilizeFirst on String {
  String getString() {
    String result = substring(0, 1).toUpperCase() + substring(1, length);
    return result;
  }
}
