import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nepalihiphub/controller/auth_controller.dart';
import 'package:nepalihiphub/controller/profile_controller.dart';
import 'package:nepalihiphub/view/profile/favourites.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final profileController = Get.put(ProfileController());
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: Colors.transparent,
          title: Text(
            "Profile",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        "Are yu sure you want to logout?",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      content: Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () => Get.back(),
                            child: Container(
                              height: 30,
                              color: Colors.grey,
                              child: Center(
                                child: Text(
                                  "No",
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ),
                            ),
                          )),
                          const SizedBox(width: 8),
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              controller.logOut();
                              Get.back();
                            },
                            child: Container(
                              height: 30,
                              color: Colors.red,
                              child: Center(
                                child: Text(
                                  "Yes",
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                            ),
                          )),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Row(
                children: [
                  const Icon(
                    Iconsax.logout,
                    color: Colors.red,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  Text(
                    "Logout",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.red),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                ],
              ),
            )
          ],
        ),
        body: Obx(
          () => SafeArea(
              child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.grey[500],
                  radius: 80,
                  backgroundImage: profileController.isLoading.value
                      ? null
                      : NetworkImage(profileController.user!.imageUrl),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                  profileController.isLoading.value
                      ? ""
                      : "${profileController.user!.firstName} ${profileController.user!.lastName} ",
                  style: Theme.of(context).textTheme.titleLarge),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const FavouritePage()));
                  },
                  child: const Text("Go to favourites"))
            ],
          )),
        ));
  }
}
