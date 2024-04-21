import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:nepalihiphub/constant/api.dart';
import 'package:nepalihiphub/model/artist_model.dart';

import 'package:nepalihiphub/services/access_token_service.dart';

class UserLibraryController extends GetxController {
  final dio = Dio();
  late UserLibraryModel userLibraryModel;
  RxBool isLoading = false.obs;

  ///init state
  @override
  void onInit() {
    super.onInit();
    getLibrary();
  }

  void updateFollowArtist(bool follow, ArtistModel artistModel) {
    if (follow) {
      userLibraryModel.artistfollowiung.add(artistModel);
    } else {
      userLibraryModel.artistfollowiung.remove(artistModel);
    }
    update();
  }

  Future<void> getLibrary() async {
    isLoading.value = true;
    try {
      String accessToken = AccessTokenService().getAccessToken();
      final headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
        'authorization': 'Bearer $accessToken'
      };
      final response =
          await dio.get(getUserLibrary, options: Options(headers: headers));
      userLibraryModel = UserLibraryModel.fromJson(response.data);
    } on DioException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }
}

class UserLibraryModel {
  final List<ArtistModel> artistfollowiung;

  UserLibraryModel({required this.artistfollowiung});

  factory UserLibraryModel.fromJson(Map<String, dynamic> json) {
    return UserLibraryModel(
      artistfollowiung: (json['artistFollowing'] as List)
          .map((e) => ArtistModel.fromJson(e))
          .toList(),
    );
  }
}
