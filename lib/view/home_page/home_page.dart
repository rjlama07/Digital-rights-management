import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nepalihiphub/constant/app_colors.dart';
import 'package:nepalihiphub/controller/nav_bar_controller.dart';
import 'package:nepalihiphub/model/beat_model.dart';

import 'package:nepalihiphub/view/producer_view/artist_profile.dart';
import 'package:nepalihiphub/view/producer_view/producer_view.dart';
import 'package:nepalihiphub/view/search/search_page.dart';
import 'package:nepalihiphub/widget/tredning_song.dart';

import '../../controller/free_beat_controller.dart';
import '../../controller/producer_profile_controller.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    // Box box = Hive.box('localData');
    // bool isLoggedIn = box.get("isLoggedin") ?? false;
    // final controller = Get.put(HomepageContoller());
    final controller = Get.put(ProducerProfileController());
    final freeBeatController = Get.put(FreeBeatController());
    final musicController = Get.put(NavBarController());

    Widget headingText(String text) {
      return Text(text, style: Theme.of(context).textTheme.titleLarge);
    }

    Widget rowHeading({required String text, required Function ontap}) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          headingText(text),
          InkWell(
            onTap: () => ontap(),
            child: Icon(
              Icons.arrow_forward_ios_outlined,
              size: 18.h,
            ),
          )
        ],
      );
    }

    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () async {
        freeBeatController.getFreebeat();
        controller.getArtist();
      },
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Get.to(const SearchPage()),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: secondaryBackgroundColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: TextField(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SearchPage()));
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Search for music",
                          suffixIcon: Icon(
                            size: 18.sp,
                            Icons.mic,
                            color: Colors.white,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: white,
                            size: 18.sp,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                rowHeading(text: "Trending Music", ontap: () {}),
                SizedBox(height: 15.h),
                Obx(
                  () => freeBeatController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                          height: 80.h,
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              width: 10,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemCount: freeBeatController.freeBeats.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  BeatModel beatModel =
                                      freeBeatController.freeBeats[index];
                                  musicController.changeMusic(
                                      imageUrl: beatModel.imageUrl!,
                                      name:
                                          "${beatModel.beatName!}-${beatModel.producerName!}",
                                      beatUrl: beatModel.beatUrl!);
                                },
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 12),
                                          height: 100,
                                          width: 300,
                                          child: InkWell(
                                            onTap: () {
                                              FileDownloader.downloadFile(
                                                url: freeBeatController
                                                    .freeBeats[index].beatUrl!,
                                                onProgress:
                                                    (fileName, progress) {},
                                                onDownloadCompleted: (path) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Dialog(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12,
                                                                  vertical: 12),
                                                          height: 100,
                                                          width: 300,
                                                          child: InkWell(
                                                            onTap: () {
                                                              FileDownloader
                                                                  .downloadFile(
                                                                url: freeBeatController
                                                                    .freeBeats[
                                                                        index]
                                                                    .beatUrl!,
                                                                onProgress:
                                                                    (fileName,
                                                                        progress) {},
                                                                onDownloadCompleted:
                                                                    (path) {},
                                                              );
                                                              Get.back();
                                                            },
                                                            child: const Row(
                                                              children: [
                                                                Icon(Icons
                                                                    .download),
                                                                SizedBox(
                                                                    width: 20),
                                                                Text("Download")
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                              Get.back();
                                            },
                                            child: const Row(
                                              children: [
                                                Icon(Icons.download),
                                                SizedBox(width: 20),
                                                Text("Download")
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: TrendingMusic(
                                  musicTitle: freeBeatController
                                      .freeBeats[index].beatName!,
                                  musicArtist: freeBeatController
                                      .freeBeats[index].producerName!,
                                  requiredViews: "100m Streams",
                                  imageUrl: freeBeatController
                                      .freeBeats[index].imageUrl!,
                                ),
                              );
                            },
                          ),
                        ),
                ),
                SizedBox(height: 15.h),
                rowHeading(
                    text: "Trending Producers",
                    ontap: () {
                      Get.to(const ProducerView());
                    }),
                SizedBox(height: 15.h),
                Obx(
                  () => controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(
                          height: 170.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.artist.length > 5
                                ? 5
                                : controller.artist.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 10),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => ArtistProfile(
                                    artistModel: controller.artist[index],
                                  ),
                                )),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: secondaryBackgroundColor,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 140.h,
                                          width: 126.w,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(controller
                                                      .artist[index]
                                                      .profileUrl)),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topRight: Radius.circular(8),
                                                topLeft: Radius.circular(8),
                                              ))),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            controller.artist[index].name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ),
                SizedBox(height: 15.h),
                headingText("Recently Listed"),
                SizedBox(height: 15.h),
                Obx(() => freeBeatController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => ListTile(
                              onTap: () {
                                musicController.changeMusic(
                                    imageUrl: freeBeatController
                                        .freeBeats[index].imageUrl!,
                                    name:
                                        "${freeBeatController.freeBeats[index].beatName!}-${freeBeatController.freeBeats[index].producerName!}",
                                    beatUrl: freeBeatController
                                        .freeBeats[index].beatUrl!);
                              },
                              contentPadding: EdgeInsets.zero,
                              leading: Container(
                                height: 45.h,
                                width: 45.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                        image: NetworkImage(freeBeatController
                                            .freeBeats[index].imageUrl!))),
                              ),
                              trailing: SizedBox(
                                width: 60.w,
                                child: Row(
                                  children: [
                                    InkWell(onTap: () {
                                      Box box = Hive.box("localData");
                                      bool isLoggedIn = box.get("isLoggedIn");
                                      if (isLoggedIn) {
                                        if (!freeBeatController
                                            .freeBeats[index].isFav!) {
                                          freeBeatController
                                              .freeBeats[index].isFav = true;
                                          freeBeatController
                                              .changeListFav(index);
                                          freeBeatController.addToFavourite(
                                              id: freeBeatController
                                                  .freeBeats[index].id!,
                                              index: index);
                                        }
                                      } else {
                                        Get.dialog(AlertDialog(
                                          title: const Text("Login"),
                                          content: const Text(
                                              "You need to login to add this to favourite"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: const Text("Cancel")),
                                            TextButton(
                                                onPressed: () {
                                                  musicController
                                                      .selectedIndex.value = 2;
                                                  Get.back();
                                                },
                                                child: const Text("Login"))
                                          ],
                                        ));
                                      }
                                    }, child: GetBuilder<FreeBeatController>(
                                        builder: (context) {
                                      return freeBeatController
                                              .freeBeats[index].isFav!
                                          ? const Icon(Icons.favorite,
                                              color: Colors.red)
                                          : const Icon(Icons.favorite_border);
                                    })),
                                    SizedBox(width: 8.w),
                                    const Icon(Iconsax.menu)
                                  ],
                                ),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    freeBeatController
                                        .freeBeats[index].beatName!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    freeBeatController
                                        .freeBeats[index].producerName!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10.h,
                            ),
                        itemCount: freeBeatController.freeBeats.length)),
                SizedBox(height: 35.h),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
