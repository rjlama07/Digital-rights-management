import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepalihiphub/model/producermodel.dart';
import 'package:nepalihiphub/services/producer_services.dart';

class ProducerProfileController extends GetxController {
  RxInt index = 0.obs;

  void changeIndex(int value) {
    index.value = value;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProducers();
  }

  RxBool isLoading = false.obs;
  RxList<ProducerModel> producers = RxList.empty();

  Future<void> getProducers() async {
    isLoading.value = true;
    final response = await ProducerServices().getProducer();
    isLoading.value = false;
    response.fold((l) {
      producers.value = l;
    }, (r) {
      print(r);
    });
  }

  TextStyle selectedTextStyle =
      const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  TextStyle unselectedTextStyle =
      const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400);
}
