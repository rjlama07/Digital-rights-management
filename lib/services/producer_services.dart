import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nepalihiphub/model/producermodel.dart';

import '../constant/api.dart';

class ProducerServices {
  Future<Either<List<ProducerModel>, String>> getProducer() async {
    try {
      final response = await Dio().get(getProducersUrl);
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
}
