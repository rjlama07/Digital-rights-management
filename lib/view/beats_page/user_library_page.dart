import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:nepalihiphub/controller/profile_controller.dart';
import 'package:nepalihiphub/controller/user_library_controller.dart';
import 'package:nepalihiphub/view/follow_artist/follow_artist_page.dart';
import 'package:nepalihiphub/view/producer_view/artist_profile.dart';

class UserLibraryPage extends StatelessWidget {
  const UserLibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileController());
    final profileController = Get.find<ProfileController>();
    final userConrtoller = Get.put(UserLibraryController());
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
              Obx(
                () => userConrtoller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          const Text(
                            "Artists you follow",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                              child: GridView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: userConrtoller
                                .userLibraryModel.artistfollowiung.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              final artist = userConrtoller
                                  .userLibraryModel.artistfollowiung[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(
                                      () => ArtistProfile(artistModel: artist));
                                },
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage:
                                          NetworkImage(artist.profileUrl),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      artist.name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                addButtton(
                                    ontap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return const FollowArtistPage();
                                        },
                                      );
                                    },
                                    text: "Add artist"),
                                const SizedBox(
                                  width: 20,
                                ),
                                addButtton(ontap: () {}, text: "Add artist"),
                              ],
                            ),
                          )
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addButtton({
    required Function ontap,
    required String text,
  }) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Column(
        children: [
          const CircleAvatar(
            radius: 30,
            child: Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          Text(text)
        ],
      ),
    );
  }
}
