import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepalihiphub/controller/free_beat_controller.dart';
import 'package:nepalihiphub/view/free_beats/widget/player.dart';

class Freebeats extends StatelessWidget {
  const Freebeats({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FreeBeatController());
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () => controller.getFreebeat(),
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                    itemCount: controller.freeBeats.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.black26),
                                    child: const Icon(Icons.music_note),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: Column(
                                          children: [
                                            Text(
                                              "${controller.freeBeats[index].producerName}-${controller.freeBeats[index].beatName}",
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.04,
                                                  fontWeight: FontWeight.w600,
                                                  color: const Color.fromRGBO(
                                                      37, 76, 104, 1)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              PlayerAudio(
                                beatUrl: controller.freeBeats[index].beatUrl!,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ));
  }
}
