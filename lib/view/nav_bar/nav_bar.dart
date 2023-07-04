import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepalihiphub/constant/app_colors.dart';
import 'package:nepalihiphub/controller/nav_bar_controller.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavBarController());
    return Scaffold(
      body: Obx(() => IndexedStack(
          index: controller.selectedIndex.value, children: controller.pages)),
      bottomNavigationBar: Container(
          color: Colors.black,
          padding: const EdgeInsets.only(bottom: 10),
          child: Obx(
            () => BottomNavigationBar(
                currentIndex: controller.selectedIndex.value,
                onTap: (value) {
                  controller.selectedIndex.value = value;
                },
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.white,
                backgroundColor: secondaryBackgroundColor,
                items: const [
                  BottomNavigationBarItem(
                      label: "Home", icon: Icon(Icons.home)),
                  BottomNavigationBarItem(
                      label: "Beats", icon: Icon(Icons.music_note)),
                  BottomNavigationBarItem(
                      label: "Favourites", icon: Icon(Icons.favorite)),
                ]),
          )),
    );
  }
}
