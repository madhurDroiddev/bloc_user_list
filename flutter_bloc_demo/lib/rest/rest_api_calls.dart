import 'package:flutter_bloc_demo/modals/response/UserListResponse.dart';
import 'package:flutter_bloc_demo/rest/api_config.dart';
import 'package:flutter_bloc_demo/rest/network_utils.dart';

class RestApiCalls {
  // next three lines makes this class a Singleton
  static RestApiCalls _instance = new RestApiCalls.internal();

  RestApiCalls.internal() {
    networkUtil = NetworkUtil();
  }

  NetworkUtil networkUtil;

  factory RestApiCalls() => _instance;

  Future<UserListResponse> getUsersList() {
    return networkUtil.get(ApiConfig.getUserList).then((value) {
      return UserListResponse.fromJson(value);
    });
  }
}
