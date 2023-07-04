import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nepalihiphub/constant/api.dart';
import 'package:nepalihiphub/model/beat_model.dart';

class BeatServices {
  final dio = Dio();

  Future<Either<List<BeatModel>, String>> getFreeBeats() async {
    try {
      final response = await dio.get(getBeat);
      List<BeatModel> list = (response.data["beats"] as List)
          .map((e) => BeatModel.fromJson(e))
          .toList();
      return left(list);
    } on DioException catch (e) {
      return right("Something went wrong:$e");
    } catch (e) {
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
}
