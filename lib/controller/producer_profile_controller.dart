import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nepalihiphub/constant/api.dart';
import 'package:nepalihiphub/model/artist_model.dart';
import 'package:nepalihiphub/model/producermodel.dart';
import 'package:nepalihiphub/services/producer_services.dart';
import 'package:nepalihiphub/view/nav_bar/nav_bar.dart';

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

  Future<void> followMultipleArtist(List<String> artistID) async {
    try {
      Box box = Hive.box("localData");
      String accessToken = box.get("accessToken") ?? "";
      final headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
        'authorization': 'Bearer $accessToken'
      };

      final response = await Dio().put(followMultipleArtistUrl,
          data: {"artistId": artistID}, options: Options(headers: headers));
      Get.to(const NavBar());
    } on DioException catch (e) {
      print(e.response!.data);
    } catch (e) {
      print(e);
    }
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
