import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nepalihiphub/model/artist_model.dart';
import 'package:nepalihiphub/model/producermodel.dart';

import '../constant/api.dart';

class ArtistServices {
  final dio = Dio();
  Future<Either<List<ProducerModel>, String>> getProducer() async {
    try {
      final response = await dio.get(getProducersUrl);
      List<ProducerModel> list = (response.data["producer"] as List)
          .map((e) => ProducerModel.fromJson(e))
          .toList();
      return left(list);
    } on DioException catch (e) {
      return right("Something went wrong:$e");
    } catch (e) {
      print(e);
      return right("Something went wrong");
    }
  }

  Future<Either<List<ArtistModel>, String>> getArtist() async {
   Box box = Hive.box("localData");
   String accessToken = box.get("accessToken") ?? "";
      final headers = {
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
          'authorization': 'Bearer $accessToken'
        };
    try {
      final response = await dio.get(getArtistUrl,options: Options(headers: headers));
      print(response.data);
      List<ArtistModel> artistList = (response.data["artists"] as List)
          .map((e) => ArtistModel.fromJson(e))
          .toList();
      return left(artistList);
    } on DioException catch (e) {
      print(e.response!.data);
      return right(e.toString());
    } catch (e) {
      return right(e.toString());
      rethrow;
    }
  }
}
