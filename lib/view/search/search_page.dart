import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nepalihiphub/constant/app_colors.dart';
import 'package:nepalihiphub/controller/search_beat.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchBeatController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
          child: Column(
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
                      : controller.beatModel.isEmpty
                          ? const Center(
                              child: Text("No data found"),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: controller.beatModel.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Container(
                                      height: 50.h,
                                      width: 50.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              controller.beatModel[index].imageUrl!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    
                                    title: Text(
                                        controller.beatModel[index].beatName!),
                                    subtitle: Text(
                                        controller.beatModel[index].beatName!),
                                  );
                                },
                              ),
                            )),
            ],
          ),
        ),
      ),
    );
  }
}
