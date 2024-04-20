import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nepalihiphub/controller/profile_controller.dart';

class UserLibraryPage extends StatelessWidget {
  const UserLibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileController());
    final profileController = Get.find<ProfileController>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Obx(
                    () => CircleAvatar(
                      radius: 18,
                      backgroundImage:
                          NetworkImage(profileController.user.value!.imageUrl),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Your Library",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Container buildContainer({
  required String title,
  required String subTitle,
  required String url,
}) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.brown, borderRadius: BorderRadius.circular(22)),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image:
                  DecorationImage(fit: BoxFit.cover, image: NetworkImage(url))),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subTitle,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
