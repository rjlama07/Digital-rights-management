import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nepalihiphub/controller/studio_controller.dart';
import 'package:nepalihiphub/view/book_studio/widget/info_container.dart';

class BookStudioPage extends StatelessWidget {
  const BookStudioPage({super.key});

  _buidlText(
      {required String text,
      double size = 15,
      FontWeight fontWeight = FontWeight.bold}) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: TextStyle(
          fontSize: size, fontFamily: "Montserrat", fontWeight: fontWeight),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudioController());
    return Scaffold(
        body: Obx(
      () => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buidlText(text: "Book Studio Sesson", size: 16),
                    const SizedBox(height: 10),
                    Expanded(
                        child: RefreshIndicator(
                      onRefresh: () => controller.getStudio(),
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return StudioInfo(
                              studioModel: controller.studio[index],
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: controller.studio.length),
                    ))
                  ],
                ),
              ),
            ),
    ));
  }
}
