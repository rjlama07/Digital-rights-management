import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nepalihiphub/constant/api.dart';
import 'package:nepalihiphub/model/studio_model.dart';

class StudioService {
  final dio = Dio();
  Future<Either<List<StudioModel>, String>> getStudioModel() async {
    try {
      final response = await dio.get(getStudiosUrl);
      List<StudioModel> list = (response.data["studio"] as List)
          .map((e) => StudioModel.formJson(e))
          .toList();
      return left(list);
    } on DioException catch (e) {
      return right("Something went wrong:$e");
    } catch (e) {
      return right("Something went wrong");
    }
  }
}
