import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nepalihiphub/constant/api.dart';
import 'package:nepalihiphub/model/album_model.dart';
import 'package:nepalihiphub/services/access_token_service.dart';

class AlbumSercies {
  AccessTokenService accessTokenService = AccessTokenService();
  Future<Either<List<AlbumModel>, String>> getAlbums() async {
    try {
      final token = await accessTokenService.getAccessToken();
      final headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
        'authorization': 'Bearer $token'
      };

      final response =
          await Dio().get(getAlbumsUrl, options: Options(headers: headers));
      List<AlbumModel> albums = (response.data["albums"] as List)
          .map((e) => AlbumModel.fromJson(e))
          .toList();
      return left(albums);
    } on DioException catch (e) {
      print(e.response!.data);

      return right("Something went wrong");
    } catch (e) {
      return right(e.toString());
    }
  }

  Future<Either<bool, String>> buyAlbum(String albumId) async {
    try {
      final token = await accessTokenService.getAccessToken();
      final headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
        'authorization': 'Bearer ${token}'
      };

      final response = await Dio().post(buyAlbumUrl,
          data: {"albumId": albumId}, options: Options(headers: headers));
      return left(true);
    } on DioException catch (e) {
      print(e.response!.data);

      return right("Something went wrong");
    } catch (e) {
      return right(e.toString());
    }
  }
}
