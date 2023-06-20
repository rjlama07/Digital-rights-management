import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:nepalihiphub/view/beats_page/beats_page.dart';
import 'package:nepalihiphub/view/favourite_page/favourite_page.dart';
import 'package:nepalihiphub/view/home_page.dart';

class NavBarController extends GetxController {
  RxInt selectedIndex = 0.obs;
  List<Widget> pages = const [Homepage(), BeatPage(), FavouritePage()];
}
