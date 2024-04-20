import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:nepalihiphub/constant/api.dart';
import 'package:nepalihiphub/model/artist_model.dart';
import 'package:nepalihiphub/model/user.dart';

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

  Future<void> getLibrary() async {
    isLoading.value = true;
    try {
      final response = await dio.get(getUserLibrary);
      userLibraryModel = UserLibraryModel.fromJson(response.data);
    } on DioException catch (e) {
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
      artistfollowiung: (json['artistfollowing'] as List)
          .map((e) => ArtistModel.fromJson(e))
          .toList(),
    );
  }
}
