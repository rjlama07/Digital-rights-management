import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepalihiphub/model/artist_model.dart';
import 'package:nepalihiphub/model/producermodel.dart';
import 'package:nepalihiphub/services/producer_services.dart';

class ProducerProfileController extends GetxController {
  RxInt index = 0.obs;

  void changeIndex(int value) {
    index.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    getArtist();
  }

  RxBool isLoading = false.obs;
  RxList<ProducerModel> producers = RxList.empty();
  RxList<ArtistModel> artist = RxList.empty();

  Future<void> getProducers() async {
    isLoading.value = true;
    final response = await ArtistServices().getProducer();
    isLoading.value = false;
    response.fold((l) {
      producers.value = l;
    }, (r) {
      print(r);
    });
  }

  Future<void> getArtist() async {
    isLoading.value = true;
    final response = await ArtistServices().getArtist();
    isLoading.value = false;
    response.fold((l) {
      artist.value = l;
    }, (r) {
      print(r);
    });
  }
}
