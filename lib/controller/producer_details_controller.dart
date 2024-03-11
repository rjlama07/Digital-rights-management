import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nepalihiphub/constant/api.dart';
import 'package:nepalihiphub/model/song_model.dart';
import 'package:nepalihiphub/services/song_service.dart';

class ProducerDetailsController extends GetxController {
  String artistId;
  ProducerDetailsController({required this.artistId});

  @override
  onInit() {
    super.onInit();
    getSongByArtist(artistId);
  }

  RxList<SongModel> song = RxList.empty();

  Future<void> followUnfollowArtist(String artistID,
      {required bool isFollowing}) async {
    try {
      Box box = Hive.box("localData");
      String accessToken = box.get("accessToken") ?? "";
      final headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
        'authorization': 'Bearer $accessToken'
      };

     final response=await Dio().put(isFollowing ? unfollowArtistUrl : followArtistURl,data: {"artistId":artistID},
          options: Options(headers: headers));
      print(response.data);
          
    } on DioException catch (e) {
      print(e.response!.data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getSongByArtist(String artistId) async {
    final response = await SongService().getSongByArtist(artistId);
    response.fold((l) {
      song.value = l;
      update();
    }, (r) {
      print(r);
    });
  }
}
