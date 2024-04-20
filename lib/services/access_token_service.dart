import 'package:hive_flutter/adapters.dart';

class AccessTokenService {
  Box box = Hive.box("localdata");

  String getAccessToken() {
    String accessToken = box.get("accessToken") ?? "";
    return accessToken;
  }

  void saveAccessToken(String accessToken) {
    box.put("accessToken", accessToken);
  }
}
