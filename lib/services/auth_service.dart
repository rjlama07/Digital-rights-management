import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nepalihiphub/constant/api.dart';

class LoginResponse {
  final String accessToken;
  final List<String> artistFollowing;

  LoginResponse({required this.accessToken, required this.artistFollowing});
}

class AuthServices {
  Box box = Hive.box("localdata");
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

  Future<Either<bool, String>> googleSignup(String token) async {
    try {
      final data = {"idToken": token};
      final response = await Dio().post(signinwithGoogleUrl, data: data);
      print(response.data);
      Hive.box("localData").put("accessToken", response.data["accessToken"]);
      // final responseData = UserModel.fromJson(response.data);
      return left(true);
    } on DioException catch (e) {
      print(e);
      if (e.toString().contains("Failed host lookup")) {
        return right("No Internet Connection");
      } else {
        return right("Error sigin with Google");
      }
    }
  }

  Future<Either<bool, String>> changePassword(
      String oldPassword, String newPassword) async {
    String accessToken = box.get("accessToken");
    final headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'authorization': 'Bearer $accessToken'
    };
    final body = {"oldPassword": oldPassword, "newPassword": newPassword};
    try {
      await dio.post(updatePassword,
          data: body, options: Options(headers: headers));
      return left(true);
    } on DioException catch (e) {
      return right(e.response!.data["error"]);
    }
  }

  Future<Either<LoginResponse, String>> login(
      String email, String password) async {
    final body = {
      "email": email,
      "password": password,
    };
    try {
      final response = await dio.post(loginUrl, data: body);
      Hive.box("localData").put("accessToken", response.data["accessToken"]);
      LoginResponse loginResponse = LoginResponse(
          accessToken: response.data["accessToken"],
          artistFollowing: response.data["artistFollowing"].cast<String>());
      return left(loginResponse);
    } on DioException catch (e) {
      return right(e.response!.data["error"]);
    }
  }
}
