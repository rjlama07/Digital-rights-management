import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nepalihiphub/constant/app_colors.dart';
import 'package:nepalihiphub/controller/nav_bar_controller.dart';
import 'package:nepalihiphub/controller/search_beat.dart';
import 'package:nepalihiphub/view/producer_view/artist_profile.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {

    final musicController = Get.find<NavBarController>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
          child: GetBuilder<SearchBeatController>(
            init: SearchBeatController(),
            builder: (controller) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.zero,
                    child: TextField(
                      onSubmitted: (value) {
                        controller.searchBeat(value);
                      },
                      readOnly: false,
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
                        filled: true,
                        fillColor: secondaryBackgroundColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Obx(() => !controller.haveSearched.value
                      ? const Center(
                          child: Text("Search for your music"),
                        )
                      : controller.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : controller.searchResult.song.isEmpty &&
                                  controller.searchResult.artist.isEmpty
                              ? const Center(
                                  child: Text("No data found"),
                                )
                              : Expanded(
                                  child: Column(
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          controller.searchResult.artist.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          // trailing: IconButton(
                                          //   padding: EdgeInsets.zero,
                                          //   constraints: BoxConstraints(
                                          //       maxHeight: 30.h, maxWidth: 30.w
                                          //   ),
                                          //   onPressed: () {
                                          //     musicController.changeMusic(
                                          //         imageUrl: controller
                                          //             .beatModel[index].imageUrl!,
                                          //         name: controller
                                          //             .beatModel[index].beatName!,
                                          //         beatUrl: controller
                                          //             .beatModel[index].beatUrl!);
                                          //   },
                                          //   icon:
                                          // ),
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                              return ArtistProfile(artistModel: controller.searchResult.artist[index]);
                                            },));
                                          },
                                          leading: Container(
                                            height: 50.h,
                                            width: 50.w,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: NetworkImage(controller
                                                    .searchResult
                                                    .artist[index]
                                                    .profileUrl),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          title: Text(controller
                                              .searchResult.artist[index].name),
                                          subtitle: Text("Artist"),
                                        );
                                      },
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          controller.searchResult.song.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          // trailing: IconButton(
                                          //   padding: EdgeInsets.zero,
                                          //   constraints: BoxConstraints(
                                          //       maxHeight: 30.h, maxWidth: 30.w
                                          //   ),
                                          //   onPressed: () {
                                          //     musicController.changeMusic(
                                          //         imageUrl: controller
                                          //             .beatModel[index].imageUrl!,
                                          //         name: controller
                                          //             .beatModel[index].beatName!,
                                          //         beatUrl: controller
                                          //             .beatModel[index].beatUrl!);
                                          //   },
                                          //   icon:
                                          // ),
                                          onTap: () {
                                            musicController.changeMusic(
                                                imageUrl:
                                                    controller.searchResult.song[index].imageUrl,
                                                name: controller.searchResult.song[index].songName,
                                                beatUrl:
                                                    controller.searchResult.song[index].songUrl);
                                          },
                                          leading: Container(
                                            height: 50.h,
                                            width: 50.w,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: NetworkImage(controller
                                                    .searchResult
                                                    .song[index]
                                                    .imageUrl),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          title: Text(controller
                                              .searchResult.song[index].songName),
                                          subtitle: Text("Song"),
                                        );
                                      },
                                    ),
                                  ],
                                ))),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
