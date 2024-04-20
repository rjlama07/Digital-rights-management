import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:nepalihiphub/services/access_token_service.dart';
import 'package:nepalihiphub/view/auth/auth_login.dart';
import 'package:nepalihiphub/view/nav_bar/nav_bar.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    final accessToken = AccessTokenService().getAccessToken();
    print(accessToken);
    Future.delayed(const Duration(seconds: 2), () {
      if (accessToken == "") {
        Get.off(const AuthPageMain());
      } else {
        Get.off(const NavBar());
      }
    });
  }
}
