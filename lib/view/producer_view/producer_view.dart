import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nepalihiphub/controller/producer_profile_controller.dart';
import 'package:nepalihiphub/view/producer_view/producer_profile.dart';

class ProducerView extends StatelessWidget {
  const ProducerView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProducerProfileController>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Obx(
              () => Column(
                mainAxisAlignment: controller.isLoading.value
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                crossAxisAlignment: controller.isLoading.value
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  if (!controller.isLoading.value)
                    const Text("Choose Producers",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Obx(() => controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Expanded(
                          child: RefreshIndicator(
                            onRefresh: () => controller.getProducers(),
                            child: GridView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: controller.producers.length,
                              semanticChildCount: 2,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(ProducerProfile(
                                        producerModel:
                                            controller.producers[index]));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(controller
                                            .producers[index].profileUrl),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(controller.producers[index].name,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(
                                              5,
                                              (rowIndex) => Icon(
                                                    Icons.star,
                                                    color: rowIndex <
                                                            (int.parse(
                                                                controller
                                                                    .producers[
                                                                        index]
                                                                    .rating))
                                                        ? Colors.yellow[400]
                                                        : Colors.grey,
                                                  )))
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ))
                ],
              ),
            )),
      ),
    );
  }
}
