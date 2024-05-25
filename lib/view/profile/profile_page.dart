import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nepalihiphub/constant/app_colors.dart';
import 'package:nepalihiphub/controller/auth_controller.dart';
import 'package:nepalihiphub/controller/profile_controller.dart';
import 'package:nepalihiphub/services/access_token_service.dart';
import 'package:nepalihiphub/view/auth/auth_login.dart';
import 'package:nepalihiphub/view/profile/setting_screens.dart';

import 'favourites.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileController());
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
            IconButton(
              onPressed: () {
                AccessTokenService().deleteAccessToken();
                Get.offAll(() => const AuthPageMain());
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: Obx(
          () => SafeArea(
              child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Center(
                          child: Text(
                            "Pick Image Source",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        content: Row(
                          children: [
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                profileController
                                    .changeProfileImage(ImageSource.camera);
                                Get.back();
                              },
                              child: Container(
                                height: 30,
                                color: Colors.red,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.camera),
                                    const SizedBox(width: 2),
                                    Text(
                                      "Camera",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                            const SizedBox(width: 8),
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                profileController
                                    .changeProfileImage(ImageSource.gallery);
                                Get.back();
                              },
                              child: Container(
                                height: 30,
                                color: Colors.red,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.image),
                                      const SizedBox(width: 2),
                                      Text(
                                        "Gallery",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                          ],
                        ),
                      );
                    },
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[500],
                    radius: 80,
                    backgroundImage: profileController.isLoading.value ||
                            profileController.isImageUploading.value
                        ? null
                        : NetworkImage(profileController.user.value!.imageUrl),
                    child: profileController.isImageUploading.value
                        ? const Center(child: CircularProgressIndicator())
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                  profileController.isLoading.value
                      ? ""
                      : "${profileController.user.value!.firstName.capitalizeFirst} ${profileController.user.value!.lastName.capitalizeFirst} ",
                  style: Theme.of(context).textTheme.titleLarge),
              // ElevatedButton(
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (_) => const FavouritePage()));
              //     },
              //     child: const Text("Go to favourites"))

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
                  child: Container(
                    padding: const EdgeInsets.only(
                        right: 16, left: 16, top: 20, bottom: 16),
                    height: 200,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: secondaryBackgroundColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        RowData(
                          onpressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const FavouritePage()));
                          },
                          label: "Favourites",
                          iconData: Iconsax.heart,
                        ),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const Divider()),
                        RowData(
                          onpressed: () {},
                          label: "My Purchase",
                          iconData: Iconsax.dollar_circle,
                        ),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const Divider()),
                        RowData(
                          onpressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SettingsScreen()));
                          },
                          label: "Settings",
                          iconData: Iconsax.setting,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
        ));
  }
}

class RowData extends StatelessWidget {
  const RowData(
      {super.key,
      required this.label,
      required this.iconData,
      required this.onpressed});
  final IconData iconData;
  final String label;
  final Function onpressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onpressed(),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 28,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20),
          )
        ],
      ),
    );
  }
}
