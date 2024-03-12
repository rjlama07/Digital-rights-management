import 'package:flutter/material.dart';
import 'package:nepalihiphub/view/home_page/home_page.dart';
import 'package:nepalihiphub/view/profile/setting_screens.dart';

final homeNavKey = GlobalKey<NavigatorState>();
String homeCurrentRoute = "/";

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: homeNavKey,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;

        // Define the routes within the profile section
        switch (settings.name) {
          case '/':
            builder = (BuildContext _) => const Homepage();

            break;
          case '/search':
            builder = (BuildContext _) => SettingsScreen();
            break;
          // Add more routes as needed

          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
