import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nepalihiphub/constant/api.dart';

class AuthServices {
  final dio = Dio();
  Future<Either<bool, String>> sigup(
      String firstname, String lastname, String email, String password) async {
    final body = {
      "firstName": firstname,
      "lastName": lastname,
      "email": email,
      "role": "user",
      "password": password,
    };
    try {
      final response = await dio.post(signUpUrl, data: body);
      Hive.box("localData").put("accessToken", response.data["accessToken"]);
      return left(true);
    } on DioException catch (e) {
      return right(e.response!.data["error"]);
    }
  }

  Future<Either<bool, String>> login(String email, String password) async {
    final body = {
      "email": email,
      "password": password,
    };
    try {
      final response = await dio.post(loginUrl, data: body);
      Hive.box("localData").put("accessToken", response.data["accessToken"]);
      return left(true);
    } on DioException catch (e) {
      return right(e.response!.data["error"]);
    }
  }
}
