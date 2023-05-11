import 'package:flutter/material.dart';
import 'package:nepalihiphub/view/profile/favourites.dart';
import 'package:nepalihiphub/view/profile/main_profile_page.dart';
import 'package:nepalihiphub/view/profile/setting_screens.dart';

class ProfileNavigator extends StatelessWidget {
  const ProfileNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        // Define the routes within the profile section
        switch (settings.name) {
          case '/':
            builder = (BuildContext _) => const MainProfilePage();
            break;
          case '/favourites':
            builder = (BuildContext _) => const FavouritePage();
            break;
          // Add more routes as needed

          case "/settings":
            builder = (BuildContext _) => SettingsScreen();
            break;

          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
