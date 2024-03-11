import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nepalihiphub/constant/api.dart';
import 'package:nepalihiphub/model/song_model.dart';

class SongService {
  Future<Either<List<SongModel>, String>> getSongByArtist(
      String artistId) async {
    try {
      final response = await Dio()
          .get(getSongbyArtist, queryParameters: {"artist": artistId});
      List<SongModel> song = (response.data["song"] as List)
          .map((e) => SongModel.fromJson(e))
          .toList();
      return Left(song);
    } catch (e) {
      return Right(e.toString());
    }
  }
}
