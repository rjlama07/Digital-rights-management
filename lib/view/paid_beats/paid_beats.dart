import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import 'package:nepalihiphub/controller/paid_beat_controller.dart';
import 'package:nepalihiphub/model/beat_model.dart';
import 'package:nepalihiphub/view/free_beats/widget/player.dart';

class PaidBeats extends StatelessWidget {
  const PaidBeats({super.key});

  @override
  Widget build(BuildContext context) {
    void payWithKhaltiApp(PaidBeatModel paidBeatModel) {
      KhaltiScope.of(context).pay(
        preferences: [PaymentPreference.khalti],
        config: PaymentConfig(
            amount: (int.parse(paidBeatModel.price.toString())) * 100,
            productIdentity: "beat",
            productName: paidBeatModel.beatName.toString()),
        onSuccess: (value) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: const Text("Payment Sucessfull"),
                actions: [
                  SimpleDialogOption(
                    child: const Text("Ok"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            },
          );
        },
        onFailure: (value) {
          debugPrint(value.toString());
        },
      );
    }

    final controller = Get.put(PaidBeatController());
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
                    itemCount: controller.paidBeats.length,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${controller.paidBeats[index].producerName}-${controller.paidBeats[index].beatName}",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.04,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          const Color.fromRGBO(
                                                              37, 76, 104, 1)),
                                                ),
                                                const SizedBox(
                                                  height: 7,
                                                ),
                                                Text(
                                                  "Rs ${controller.paidBeats[index].price}",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black54),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              PlayerAudio(
                                beatUrl: controller.paidBeats[index].sampleUrl!,
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: InkWell(
                                  onTap: () {
                                    payWithKhaltiApp(
                                        controller.paidBeats[index]);
                                    // Get.to(const PaymentPage());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
                                    child: const Text(
                                      "Buy now",
                                      style: TextStyle(color: Colors.white),
                                    ),
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
        ));
  }
}
