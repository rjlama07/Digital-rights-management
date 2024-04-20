import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nepalihiphub/controller/follow_artist_intital_controller.dart';
import 'package:nepalihiphub/controller/producer_details_controller.dart';
import 'package:nepalihiphub/controller/producer_profile_controller.dart';
import 'package:nepalihiphub/controller/profile_controller.dart';

class FollowArtistPage extends StatelessWidget {
  const FollowArtistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    final artistController = Get.put(ProducerProfileController());
    final artistInitialController = Get.put(FolowArtistInitialController());

    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Obx(
            () => artistController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetBuilder<FolowArtistInitialController>(
                        builder: (controller) {
                          bool isEmpty = artistInitialController
                              .selecttedArtist.isNotEmpty;
                          return Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                if (isEmpty) {
                                  artistController.followMultipleArtist(
                                    artistInitialController.selecttedArtist,
                                  );
                                }
                              },
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: isEmpty
                                        ? Colors.blue
                                        : Colors.blue.withOpacity(0.5)),
                              ),
                            ),
                          );
                        },
                      ),
                      Text(
                          "Hi ${profileController.user.value!.firstName} follow some of your favourite artist "),
                      const SizedBox(height: 20),
                      Expanded(
                          child: GridView.builder(
                        itemCount: artistController.artist.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 20,
                                crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              artistInitialController
                                  .addArtist(artistController.artist[index].id);
                            },
                            child: Column(
                              children: [
                                GetBuilder<FolowArtistInitialController>(
                                    builder: (context) {
                                  return Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(
                                            artistController
                                                .artist[index].profileUrl),
                                      ),
                                      Visibility(
                                        visible: artistInitialController
                                            .selecttedArtist
                                            .contains(artistController
                                                .artist[index].id),
                                        child: const Positioned(
                                          right: 10,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.blue,
                                            radius: 15,
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                }),
                                const SizedBox(height: 2),
                                Text(artistController.artist[index].name),
                              ],
                            ),
                          );
                        },
                      ))
                    ],
                  ),
          )),
    ));
  }
}
