import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepalihiphub/controller/favourite_controller.dart';
import 'package:nepalihiphub/controller/nav_bar_controller.dart';
import 'package:nepalihiphub/widget/tredning_song.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouriteController());
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          title: const Text("Favourite"),
        ),
        body: Obx(() => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: controller.freeBeats.length,
                  itemBuilder: (context, index) {
                    final data = controller.freeBeats[index];
                    return InkWell(
                      onTap: () {
                        Get.find<NavBarController>().playSingleSong(
                            beatId: data.id!,
                            imageUrl: data.imageUrl!,
                            name: data.beatName!,
                            beatUrl: data.beatUrl!);
                      },
                      child: TrendingMusic(
                          musicArtist: data.producerName!,
                          musicTitle: data.beatName!,
                          imageUrl: data.imageUrl!,
                          requiredViews: "100 m"),
                    );
                  },
                ),
              )));
  }
}
