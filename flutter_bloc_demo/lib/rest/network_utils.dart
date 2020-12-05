import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'api_config.dart';

class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();
  Dio dio;

  NetworkUtil.internal() {
    dio = Dio()..options.baseUrl = ApiConfig.BASE_URL;
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  factory NetworkUtil() => _instance;

  Future<dynamic> post(
      {Key key,
      String url,
      var body,
      String token,
      bool isFormData: false,
      BuildContext context}) async {
    Map<String, String> map = new Map();
    map["Accept"] = "application/json";
    if (token != null) {
      map["Authorization"] = "Bearer " + token;
    }

    Options options = Options(
        headers: map,
        contentType: isFormData ? "multipart/form-data" : "application/json");

    return await dio
        .post(Uri.encodeFull(url), data: body, options: options)
        .then((response) async {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        if (statusCode == 401) {
          throw new Exception("401");
        } else {
          throw new Exception("Error while fetching data");
        }
      }
      return response.data;
    }).catchError((errorResponse) {
      if (errorResponse.response.statusCode == 401) {
        logout(context);
      }
      return errorResponse.response.data;
    });
  }

  Future<dynamic> deleteApi(String url, {String token, body}) {
    Map<String, String> map = new Map();
    map["Content-Type"] = "application/json";
    if (token != null) {
      map["Authorization"] = "Bearer " + token;
    }

    Options options = Options(headers: map);

    return dio.delete(url, options: options).then((response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        if (statusCode == 401) {
          throw new Exception("401");
        } else {
          throw new Exception("Error while fetching data");
        }
      }
      return response.data;
    }).catchError((errorResponse) {
      return errorResponse.response.data;
    });
  }

  Future<dynamic> get(String url,
      {String token, queryMap, BuildContext context}) {
    Map<String, String> map = new Map();
    Map<String, dynamic> queryParams = new Map();
    map["Content-Type"] = "application/json";
    if (token != null) {
      map["Authorization"] = "Bearer " + token;
    }

    if (queryMap != null) {
      queryParams = queryMap;
    }

    Options options = new Options(headers: map);

    return dio
        .get(Uri.encodeFull(url),
            options: options, queryParameters: queryParams)
        .then((response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        if (statusCode == 401) {
          throw new Exception("401");
        } else {
          throw new Exception("Error while fetching data");
        }
      }
      return response.data;
    }).catchError((errorResponse) {
      if (errorResponse.response.statusCode == 401) {
        logout(context);
      }
      return errorResponse.response.data;
    });
  }

  Future<dynamic> putApi(
      {body, String url, String token, bool isFormData: false}) {
    Map<String, String> map = new Map();

    if (!isFormData) {
//      map["Content-Type"] = "application/json";
    } else {
//      map["Content-Type"] = "multipart/form-data";
      map["Accept"] = "application/json";
    }

    if (token != null) {
      map["Authorization"] = "Bearer " + token;
    }

    Options options = Options(
        headers: map,
        contentType: isFormData ? "multipart/form-data" : "application/json");
    return dio.put(url, data: body, options: options).then((response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 500 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return response.data;
    }).catchError((error) {
      return error.response.data;
    });
  }

  logout(BuildContext context) async {

  }
}
