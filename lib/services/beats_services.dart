import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nepalihiphub/constant/api.dart';
import 'package:nepalihiphub/model/beat_model.dart';

class BeatServices {
  final dio = Dio();
  Box box = Hive.box("localdata");

  Future<Either<List<BeatModel>, String>> getFreeBeats(String url) async {
    String accessToken = box.get("accessToken") ?? "";
    final headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'authorization': 'Bearer $accessToken'
    };
    try {
      final response = await dio.get(url, options: Options(headers: headers));
      List<BeatModel> list = (response.data["beats"] as List)
          .map((e) => BeatModel.fromJson(e))
          .toList();
      return left(list);
    } on DioException catch (e) {
      return right("Something went wrong:$e");
    } catch (e) {
      print(e);
      return right("Something went wrong");
    }
  }

  Future<Either<List<PaidBeatModel>, String>> getPaidBeats() async {
    try {
      final response = await dio.get(getPaidBeatUrl);
      List<PaidBeatModel> list = (response.data["paidBeat"] as List)
          .map((e) => PaidBeatModel.fromJson(e))
          .toList();
      return left(list);
    } on DioException catch (e) {
      return right("Something went wrong:$e");
    } catch (e) {
      return right("Something went wrong");
    }
  }

  Future<Either<List<BeatModel>, String>> searchBeat(
      String queryParameter) async {
    String accessToken = box.get("accessToken") ?? "";
    final headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'authorization': 'Bearer $accessToken'
    };
    try {
      final response = await dio.get(searchBeatUrl,
          queryParameters: {"search": queryParameter},
          options: Options(headers: headers));
      List<BeatModel> beat = (response.data["beats"] as List)
          .map((e) => BeatModel.fromJson(e))
          .toList();

      return left(beat);
    } on DioException catch (e) {
      return right("Something went wrong:$e");
    } catch (e) {
      return right("Something went wrong");
    }
  }
}
